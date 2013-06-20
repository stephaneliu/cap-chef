require "bundler/capistrano"

set :application, "[[application name]]"

# comment/remove next two lines if not using rvm
set :rvm_ruby_string, "1.9.3-p327@#{application}"
require "rvm/capistrano"


load "config/recipes/base"
load "config/recipes/check"
load "config/recipes/mysql"
load "config/recipes/nginx"
load "config/recipes/nodejs"
load "config/recipes/rvm"
load "config/recipes/unicorn"

server "[[ip of server]]", :web, :app, :db, primary: true

set :user,        'deployer'
set :port,        "[[ port]]"
set :git_repo,    "[[ git_repo ]]"
set :deploy_to,   "/home/#{user}/apps/#{application}"
set :deploy_via,  :remote_cache
set :use_sudo,    false

set :scm,         "git"
set :repository,  "[[ git@github.com:somewhere/#{application}.git ]]"
set :branch,      "master"

set :maintenance_template_path, File.expand_path("../recipes/templates/maintenance.html.erb", __FILE__)

default_run_options[:pty]   = true  # password prompt 
ssh_options[:forward_agent] = true  # key passthrough for git repo

after "deploy", "deploy:cleanup"    # keep only the last 5 releases
