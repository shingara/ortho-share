class Materiels < Application

  before :ensure_authenticated

  def index
    @conditions = {}
    @conditions[:category] = params[:category] || Materiel::CATEGORY.first
    @conditions[:sub_category] = params[:sub_category] || Materiel::SUB_CATEGORY.first
    @materiels = Materiel.paginate(:conditions => @conditions,
                                   :per_page => 10, 
                                   :page => (params[:page] || 1))
    render
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
