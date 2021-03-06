class Users < Application
  # provides :xml, :yaml, :js

  before :ensure_authenticated, :exclude => [:new, :create]
  before :only_own_account, :only => [:edit, :update]
  before :need_admin, :only => [:index, :activate]

  params_accessible :user => [:login, :firstname, :lastname, :email, :password, :password_confirmation]

  def new
    only_provides :html
    @user = User.new
    @title = "Nouveau compte"
    display @user
  end

  ## 
  # Check all user in application
  # We can activated or not after
  #
  def index
    @users = User.paginate(:page => (params[:page] || 1),
                           :per_page => 10)
    display @users
  end

  def activate(id)
    @user = User.find(id)
    if @user.activate!
      send_mail(UserMailer, :account_activate, {:from => ADMIN_EMAIL,
                                                :to => @user.email,
                                                :subject => '[ORTHO-PARTAGE] Compte a été validé'},
                                                {:user => self})
    end
    redirect resource(:users)
  end

  def show(id)
    @user = User.find(id)
    display @user
  end

  def edit(id)
    only_provides :html
    @user = session.user
    @title = "modifier mon profil"
    display @user
  end

  def create(user)
    @user = User.new(user)
    if @user.save
      send_mail(AdminMailer, :new_user, {
        :from => ADMIN_EMAIL,
        :to => User.admins.map(&:email).join(','),
        :subject => '[ORTHO-PARTAGE] Nouvelle utilisateur créé',
      }, {:user => @user })
      redirect resource(@user, :edit), :message => {:notice => "Votre compte a été créé avec succès"}
    else
      message[:error] = "Le compte n'a pas été créé"
      render :new
    end
  end

  def update(id, user)
    @user = User.find(id)
    raise NotFound unless @user
    if @user.update_attributes(user)
       redirect '/'
    else
      display @user, :edit
    end
  end

  def destroy(id)
    @user = User.get(id)
    raise NotFound unless @user
    if @user.destroy
      redirect resource(:users)
    else
      raise InternalServerError
    end
  end

  private

  def only_own_account
    @user = User.find(params[:id])
    unless @user == session.user
      raise Unauthenticated
    end
  end

end # Users
