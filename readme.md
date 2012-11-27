# Welcome to Bradley Online

This is the project for my personal blog, hosted at bradley-online.com

However, anyone should feel free to take any and all of this code and do what you will with it.

## Deploying

This is my own capistrano recipe. You'll want to run `deploy:setup` to get all your config files into the shared directory where you can set up your database information in `database.yml`, and run `rake secret` to get a fresh secret token to put into `application.yml`

```
#deploy.rb
require "bundler/capistrano" 

server "xxx.xxx.xxx.xxx", :app, :web, :db, :primary => true
set :application, "bradley_online"

#rackspace stuff
set :user, "deployer"
set :password, "password"
set :use_sudo,    false
set :deploy_to,   "/home/#{user}/apps/#{application}"
ssh_options[:forward_agent] = true
default_run_options[:pty] = true

#github stuff
default_run_options[:pty] = true
set :repository,  "git://github.com/user/repo.git"
set :scm, :git
set :branch, "master"
set :scm_username, "user"
set :scm_passphrase, "password"

after "deploy", "deploy:cleanup"

namespace :deploy do
  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command, roles: :app, except: {no_release: true} do
      run "/etc/init.d/unicorn_#{application} #{command}"
    end
  end

  task :setup_config, roles: :app do
    sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
    sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
    run "mkdir -p #{shared_path}/config"
    put File.read("config/database.example.yml"), "#{shared_path}/config/database.yml"
    put File.read("config/application.example.yml"), "#{shared_path}/config/application.yml"
    puts "Now edit the config files in #{shared_path}."
  end
  after "deploy:setup", "deploy:setup_config"

  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/application.yml #{release_path}/config/application.yml"
  end
  after "deploy:finalize_update", "deploy:symlink_config"

  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end
  before "deploy", "deploy:check_revision"
end
```