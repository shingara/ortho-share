set :application, "ortho-partage"
set :repository,  "git://github.com/shingara/ortho-share.git"
set :domain, "shingara.fr"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/var/rails/ortho-share"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion
set :scm, :git

set :runner, "rails"
set :user, "rails"
set :use_sudo, false

set :thin_conf, "/etc/thin/ortho-partage.yml"

role :app, domain
role :web, domain
role :db,  domain, :primary => true

task :update_config, :roles => [:app] do
  run "ln -s #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  run "ln -s #{shared_path}/uploads #{release_path}/public/uploads"
end

namespace :deploy do
  task :start, :roles => [:app] do
    run "thin -C #{thin_conf} start"
  end

  task :stop, :roles => [:app] do
    run "thin -C #{thin_conf} -f stop"
  end

  task :restart, :roles => [:app] do
    run "thin -C #{thin_conf} -f restart"
  end
end

task :install_gem, :roles => [:app] do
  run "cd #{release_path} && /var/lib/gems/1.8/bin/thor merb:gem:redeploy && /var/lib/gems/1.8/bin/thor merb:gem:install"
end


after "deploy:update_code", :update_config
after "deploy:update_code", :install_gem
