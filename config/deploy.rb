require 'bundler/capistrano'

default_run_options[:pty] = true
default_run_options[:env] = {:GIT_SSL_NO_VERIFY => true}
ssh_options[:forward_agent] = true


server '10.131.125.74', :app, :web, :db, :primary => true # web2

# Deploys the current branch
set :branch,        `git branch --no-color`.match(/\*\s(.+)\n/)[1]
set :deploy_to,     "/opt/www/resque-web"

set :application, "resque-web"

$:.unshift(File.expand_path('./lib', ENV['rvm_path']))  # Add RVM's lib directory to the load path.
require "rvm/capistrano"                                # Load RVM's capistrano plugin.

set :repository, "git@github.com:shermanstravel/#{application}.git"
set :scm, :git
set :user, "capistrano"

set :scm_verbose, false
set :normalize_asset_timestamps, false
set :use_sudo, false

namespace :deploy do
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end
  task :stop do ; end
  task :start do ; end
end
