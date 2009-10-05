class Unactivated < Exception
  
end

class Materiels < Application

  provides :html, :js, :json

  before :ensure_authenticated
  before :need_activated
  before :need_admin, :only => [:delete, :destroy]

  def index
    @conditions = {}
    @conditions[:category] = params[:category] || Materiel::CATEGORY.first
    @conditions[:sub_category] = params[:sub_category] || Materiel::SUB_CATEGORY.first
    @page = params[:page] || 1
    @materiels = Materiel.paginate(:conditions => @conditions,
                                   :per_page => 10, 
                                   :page => @page)
    @nb_materiels = Materiel.count(@conditions)
    @num_start_element = @nb_materiels > 0 ? (@page.to_i * 10) - 9 : 0
    @num_end_element = @page.to_i * 10
    @num_end_element = @nb_materiels if @nb_materiels < @num_end_element
    render
  end

  def new
    @materiel = Materiel.new
    @uuid = UUID.generate
    display @materiel
  end

  def show(id)
    @materiel = Materiel.find(id)
    display @materiel
  end

  def create
    @materiel = Materiel.new(params[:materiel].update(:from => session.user))
    if @materiel.save
      send_mail(AdminMailer, :new_document, {:from => ADMIN_EMAIL,
                                             :to => User.admins.map(&:email).join(','),
                                             :subject => '[ORTHO-PARTAGE] un nouveau document a été ajouté'},
                                            {:document => @materiel})
      redirect resource(:materiels), :message => {:notice => 'Votre document a été créé avec succès'}
    else
      render :new
    end
  end

  def delete(id)
    @materiel = Materiel.find(id)
    display @materiel
  end
  
  def destroy(id)
    Materiel.destroy(id)
    redirect resource(:materiels), :message => {:notice => 'Document supprimé'}
  end

  private

  def need_activated
    unless session.user && session.user.activated?
      raise Unactivated
    end
  end

end
