source 'https://rubygems.org'

gem 'rails', '3.2.17'

gem 'ancestry'
gem 'aws-sdk'
gem 'capistrano'
gem 'cancan'
gem 'daemons'
gem 'delayed_job_active_record'
gem 'devise'
gem 'devise-encryptable'
gem 'dragonfly', '~>0.9.8'
gem 'fog' # For dragonfly s3
gem 'gibbon'
gem 'jquery-rails'
gem 'pg'
gem 'nested_form', git: 'https://github.com/fxposter/nested_form.git'
gem 'rack'
gem 'rack-cache', require: 'rack/cache'
gem 'rack-recaptcha', require: 'rack/recaptcha'
gem 'sunspot_rails'
gem 'streamy_csv'
gem 'whenever', require: false
gem 'will_paginate'
gem 'simple_form'
gem 'zeroclipboard-rails'
gem "geocoder", '~> 1.3.4'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'asset_sync'
  gem 'sass-rails', '~> 3.2.3'
  # turbo sprockets isn't uploading the jquery ui file.
  #gem 'turbo-sprockets-rails3'
  gem 'uglifier', '>= 1.0.3'
end

group :development do
  gem 'annotate', git: 'git://github.com/jeremyolliver/annotate_models.git', branch: 'rake_compatibility'
  gem 'bullet'
  gem 'capistrano_colors'
  gem 'factory_girl_rails'
  gem 'quiet_assets'
  gem 'rack-mini-profiler'
  gem 'rails_best_practices'
  gem 'railroady'
  #gem 'rspec-rails'
  gem 'sunspot_solr' # A standalone solr server for development
  gem 'thin'
  # griffin's dev crap
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'byebug'
end

group :eggo do
  gem 'sunspot_solr' # A standalone solr server for development
end

group :production do
  gem 'dalli'
  gem 'exception_notification'
  gem 'execjs'
  gem 'therubyracer', platforms: :ruby
end

group :test do
  gem 'cucumber-rails'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'rspec-rails'
end
group :stage do
  gem 'sunspot_solr' # A standalone solr server for development
end

