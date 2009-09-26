class Materiel

  include MongoMapper::Document

  CATEGORY = ['materiel',
    'test',
    'documentation']
  SUB_CATEGORY = ['langage oral',
    'langage écrit']
  
  key :name, String, :required => true, :unique => true
  key :description, String, :required => true
  key :category, String, :required => true
  key :sub_category, String, :required => true
  key :from_id, String, :required => true

  timestamps!

  mount_uploader :doc, DocUploader

  belongs_to :from, :class_name => 'User'

  validates_true_for :doc,
    :logic => lambda { !self.doc.filename.nil? },
    :message => 'doit etre présent'

  after_create :up_nb_document

  def up_nb_document
    from.nb_document = from.nb_document.next
    from.save!
  end

end
