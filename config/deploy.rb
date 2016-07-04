require 'bundler/capistrano' # cap -e bundle:install
require 'capistrano_colors'
require 'delayed/recipes' # delayed job

load 'deploy/assets'

set :application, "nyccollegeline.org"
set :repository,  "git@github.com:blenderbox/nyc-college-line.git"
set :scm, :git
set :deploy_via, :remote_cache

default_run_options[:pty] = true
ssh_options[:paranoid] = false
ssh_options[:forward_agent] = true

set :port, 837

task :eggo do
  set :rails_env, 'stage'
  #set :branch, 'stage'
  set :branch, 'stage'
  set :deploy_to, "/var/www/stage.cl.blenderbox.com"
  set :user, "deploy-grad-nyc"
  set :password, 'grad-nyc'
  set :use_sudo, false
  server 'eggo.blenderbox.com', :app, :web, :db, primary: true

  before 'deploy:update', 'sunspot:stop'
  after 'deploy:update_code', 'sunspot:start'
end

task :stage do
  set :bundle_without, [:development, :test, :eggo]
  set :rails_env, 'stage'
  set :branch, 'stage'
  #set :branch, 'responsive'
  set :deploy_to, "/var/www/stage.nyccollegeline.org"
  server '54.172.251.183', :app, :web, :db, primary: true
  set :user, "deploy"
end

task :prod do
  set :bundle_without, [:development, :test, :eggo]
  set :rails_env, 'production'
  set :branch, 'production'
  set :deploy_to, "/var/www/nyccollegeline.org"
  server '54.172.251.183', :app, :web, :db, primary: true
  set :user, "deploy"

  #after 'deploy:update_code', 'sunspot:reindex'

  set :whenever_command, "bundle exec whenever"
  set :whenever_roles, [:app]
  require "whenever/capistrano"
end

namespace :deploy do
  desc "Restarting nginx with restart.txt"
  task :restart, roles: :app, except: { no_release: true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, roles: :app do ; end
  end

  task :clear_cache, roles: [:app] do
    run "cd #{current_path}; RAILS_ENV=#{rails_env} bundle exec rake cache:clear" rescue "Couldn't restart cache"
  end

end
# The deploy life-cycle
after "deploy", "deploy:cleanup"
before("deploy:cleanup") { set :use_sudo, false }
before "deploy:restart", "deploy:clear_cache"
after "deploy:rollback:revision", "bundler:install"

namespace :nyc_college_line do
  task :symlink do
    run "ln -nfs #{shared_path}/config/database.yml #{latest_release}/config/database.yml"
    run "ln -nfs #{shared_path}/config/secrets.yml #{latest_release}/config/secrets.yml"
    run "mkdir -p #{latest_release}/tmp/batch-uploads" # make the directory for batch-uploads
  end
end
before "deploy:assets:symlink", "nyc_college_line:symlink"

namespace :dragonfly do
  desc "Symlink the Rack::Cache files"
  task :symlink, roles: [:app] do
    run "mkdir -p #{shared_path}/tmp/dragonfly && ln -nfs #{shared_path}/tmp/dragonfly #{latest_release}/tmp/dragonfly"
  end
end
before 'deploy:assets:symlink', 'dragonfly:symlink'

namespace :sunspot do
  desc "Reindex for Sunspot"
  task :reindex, roles: [:app] do
    run "cd #{latest_release}; RAILS_ENV=#{rails_env} rake sunspot:solr:reindex" rescue "Couldn't reindex"
  end
  task :start, roles: [:app] do
    run "cd #{current_path}; RAILS_ENV=#{rails_env} bundle exec rake sunspot:solr:start" rescue "Couldn't start solr"
  end
  task :stop, roles: [:app] do
    run "cd #{current_path}; RAILS_ENV=#{rails_env} bundle exec rake sunspot:solr:stop" rescue "Couldn't stop solr"
  end
end

# Delayed Job
after 'deploy:stop', 'delayed_job:stop'
after 'deploy:start', 'delayed_job:start'
after 'deploy:restart', 'delayed_job:restart'
