set_default :ruby_version, "1.9.3-p327"

# RVM capistrano plugin configuration
set :rvm_type, :system
set :rvm_install_type, :stable
set :rvm_install_with_sudo, true

namespace :rvm do
  # Inherited from rvm/capistrano
  before 'deploy:setup', 'rvm:install_rvm'
  before 'deploy', 'rvm:install_rvm'

  desc "Install bundler gem and ruby "
  task :bundler, roles: :app do
    run "rvm --default use #{ruby_version}"
    run "rvm use #{ruby_version}@global"
    run "gem install bundler --no-ri --no-rdoc"
  end
  after "deploy:install", "rvm:bundler"
end
