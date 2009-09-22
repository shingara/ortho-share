class Materiel

  include MongoMapper::Document
  
  key :name, String, :required => true
  key :category, String, :required => true
  # materiel/test/documentation seul category possible
  key :sub_category, String, :required => true
  key :from_id, String, :required => true

  timestamps!

  mount_uploader :doc, DocUploader

  belongs_to :from, :class_name => 'User'

end
