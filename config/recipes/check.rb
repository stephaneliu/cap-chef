namespace :check do
  desc "Make sure local git is in sync with remote."
  task :version, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as the origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end
  before "deploy", "check:version"
  before "deploy:migrations", "check:version"
  before "deploy:cold", "check:version"
end
