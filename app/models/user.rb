require 'lib/mongomapper_salted_user.rb'

class User

  include MongoMapper::Document

  extend Merb::Authentication::Mixins::SaltedUser::MongoMapperClassMethods

  key :login, String, :required => true
  key :email, String, :required => true

  many :materiels, :foreign_key => 'from_id'

  timestamps!

end
