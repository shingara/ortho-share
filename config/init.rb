# Go to http://wiki.merbivore.com/pages/init-rb
 
require 'config/dependencies.rb'
 
use_test :rspec
use_template_engine :haml
 
Merb::Config.use do |c|
  c[:use_mutex] = false
  c[:session_store] = 'cookie'  # can also be 'memory', 'memcache', 'container', 'datamapper
  
  # cookie session store configuration
  c[:session_secret_key]  = '6f29bcb20c69d0d74c786a6bab7caabd7f41f4d0'  # required for cookie session store
  c[:session_id_key] = '_merb_app_session_id' # cookie session id key, defaults to "_session_id"
  c[:adapter] = 'thin' unless c[:adapter] == 'irb' || c[:adapter] == 'runner'
end
 
Merb::BootLoader.before_app_loads do
  # This will get executed after dependencies have been loaded but before your app's classes have loaded.
  Merb::Mailer.delivery_method = :sendmail
end
 
Merb::BootLoader.after_app_loads do
  load_from_source('will_paginate')
end

def load_from_source(src)
  $:.unshift File.join(Merb.root, "src/#{src}/lib")
  require "src/#{src}/init.rb"
end

ADMIN_EMAIL = 'admin@ortho-partage.shingara.fr'
