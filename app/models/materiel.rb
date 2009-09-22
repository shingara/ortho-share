class Materiel

  include MongoMapper::Document
  
  key :name, String, :required => true
  key :category, String, :required => true
  key :sub_category, String, :required => true

  timestamps!

  belongs_to :from, :class_name => User

end
