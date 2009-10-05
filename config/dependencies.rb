# dependencies are generated using a strict version, don't forget to edit the dependency versions when upgrading.
merb_gems_version = "1.0.12"

# For more information about each component, please read http://wiki.merbivore.com/faqs/merb_components
dependency "thor", "0.9.9"
dependency "merb-core", merb_gems_version 
dependency "merb-action-args", merb_gems_version
dependency "merb-assets", merb_gems_version  
dependency("merb-cache", merb_gems_version) do
  Merb::Cache.setup do
    register(Merb::Cache::FileStore) unless Merb.cache
  end
end
dependency "merb-helpers", merb_gems_version 
dependency "merb-slices", merb_gems_version  
dependency "merb-auth-core", merb_gems_version
dependency "merb-auth-more", merb_gems_version
dependency "merb-auth-slice-password", merb_gems_version
dependency "merb-param-protection", merb_gems_version
dependency "merb-mailer", merb_gems_version
dependency "merb-exceptions", merb_gems_version
dependency "merb-haml", merb_gems_version

dependency "mongodb-mongo_ext", :require_as => false
dependency "mongomapper", "0.4.1", :require_as => 'mongomapper'
dependency "merb_mongomapper", "0.1.6", :require_as => 'merb_mongomapper'
dependency "machinist_mongomapper", "0.9.4", :source => 'http://gems.github.com', :require_as => 'machinist/mongomapper'
dependency "randexp"
dependency 'carrierwave'
dependency "uuid"
