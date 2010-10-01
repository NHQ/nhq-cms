require 'bundler/capistrano'

set :application, "nhq-cms"
set :repository,  "git@github.com:NHQ/nhq-cms.git"

set :scm, :git
set :user, "deploy"
set :use_sudo, false
set :deploy_to, "/home/deploy/#{application}"

role :web, "173.212.203.4"
role :app, "173.212.203.4"
role :db,  "173.212.203.4", :primary => true 

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

 namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end
   task :config_symlink do
    run "ln -nsf #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nsf #{shared_path}/config/mongoid.yml #{release_path}/config/mongoid.yml"
    run "ln -nsf #{shared_path}/log #{release_path}/log"
   end
 end

 after 'deploy:update_code', 'deploy:config_symlink'
