require 'lib/mongomapper_salted_user.rb'

class User

  include MongoMapper::Document

  extend Merb::Authentication::Mixins::SaltedUser::MongoMapperClassMethods

  key :login, String, :required => true
  key :email, String, :required => true
  key :global_admin, Boolean, :default => false
  key :activated, Boolean, :default => false
  key :nb_document, Integer, :default => 0

  many :materiels, :foreign_key => 'from_id'

  timestamps!

  before_save :update_nb_document

  def activate!
    self.activated = true
    save!
  end

  def update_nb_document
    self.nb_document = Materiel.count({:from_id => self.id})
  end

  def self.admins
    User.all(:conditions => {:global_admin => true})
  end


end
