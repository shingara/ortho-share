class Materiel

  include MongoMapper::Document

  CATEGORY = ['materiel',
    'test',
    'documentation']
  SUB_CATEGORY = ['langage oral',
    'langage écrit']
  
  key :name, String, :required => true
  key :category, String, :required => true
  key :sub_category, String, :required => true
  key :from_id, String, :required => true

  timestamps!

  mount_uploader :doc, DocUploader

  belongs_to :from, :class_name => 'User'

end
