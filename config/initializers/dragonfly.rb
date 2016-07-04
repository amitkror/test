require 'dragonfly/rails/images'

unless defined?(CONFIG)
  CONFIG = YAML.load_file("#{Rails.root}/config/nyccollegeline.yml")[Rails.env]
end

if Rails.env.production? || Rails.env.stage?
  app = Dragonfly[:images]
  app.datastore = Dragonfly::DataStorage::S3DataStore.new
  app.datastore.configure do |c|
    c.bucket_name = CONFIG['s3_bucket']
    c.access_key_id = CONFIG['aws_access_key_id']
    c.secret_access_key = CONFIG['aws_secret_access_key']
    c.url_host = CONFIG['s3_host'].gsub('http://', '')
  end
end
