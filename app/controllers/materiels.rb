class Materiels < Application

  before :ensure_authenticated

  def index
    @materiels = Materiel.paginate(:per_page => 10, 
                                   :page => (params[:page] || 1))
    render
  end

  def documentations
    @materiels = Materiel.paginate(:conditions => {:category => 'documentation'},
                                   :per_page => 10, 
                                   :page => (params[:page] || 1))
    render :index
  end

  def tests
    @materiels = Materiel.paginate(:conditions => {:category => 'test'},
                                   :per_page => 10, 
                                   :page => (params[:page] || 1))
    render :index
  end

  def materiels
    @materiels = Materiel.paginate(:conditions => {:category => 'materiel'},
                                   :per_page => 10, 
                                   :page => (params[:page] || 1))
    render :index
  end

  def new
    @materiel = Materiel.new
    display @materiel
  end

  def create
    @materiel = Materiel.new(params[:materiel].update(:from => session.user))
    if @materiel.save
      redirect resource(:materiels), :message => {:notice => 'Votre document a été créé avec succès'}
    else
      render :new
    end
  end

end
