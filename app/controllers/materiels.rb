class Materiels < Application

  before :ensure_authenticated

  def index
    @materiels = Materiel.paginate(:per_page => 10, 
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
      redirect resource(:materiels, :new)
    else
      render :new
    end
  end

end
