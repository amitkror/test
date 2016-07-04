# encoding: utf-8

##
# Backup Generated: nyc_collegeline_production_backup
# Once configured, you can run the backup with the following command:
#
# $ backup perform -t nyc_collegeline_production_backup [-c <path_to_configuration_file>]
#
# For more information about Backup's components, see the documentation at:
# http://meskyanichi.github.io/backup
#

##
# This file is generated by this command:
#    backup generate:model -t garden_backup --databases="postgresql" --storages="s3" --compressor="gzip" --notifiers="mail" --config-file ./config/backup/backup.rb


ENV = "production"

# This means that backup needs to be ran relative to project root (see schedule.rb)
secrets = YAML.load(File.open("config/secrets.yml"))[ENV]
db_config = YAML.load(File.open("config/database.yml"))[ENV]

Model.new(:nyc_collegeline_production_backup, 'Description for nyc collegeline production backup') do

  ##
  # PostgreSQL [Database]
  #
  database PostgreSQL do |db|
    # To dump all databases, set `db.name = :all` (or leave blank)
    db.name               = db_config["database"]
    db.username           = db_config["username"] if db_config["username"]
    db.password           = db_config["password"] if db_config["password"]
    db.host               = db_config["host"] if db_config["host"]
    db.port               = db_config["port"] if db_config["port"]
    # db.socket             = "/tmp/pg.sock"

    # When dumping all databases, `skip_tables` and `only_tables` are ignored.
    # db.skip_tables        = ["skip", "these", "tables"]
    # db.only_tables        = ["only", "these", "tables"]

    db.additional_options = ["-O"]
  end

  ##
  # Amazon Simple Storage Service [Storage]
  #
  store_with S3 do |s3|
    # AWS Credentials
    s3.access_key_id     = secrets["backup_aws_access_key_id"]
    s3.secret_access_key = secrets["backup_aws_secret_access_key_id"]

    s3.region            = secrets["backup_s3_region"]
    s3.bucket            = secrets["backup_s3_bucket"]
    s3.path              = secrets["backup_s3_path"]

    print s3.inspect
  end

  ##
  # Gzip [Compressor]
  #
  compress_with Gzip


  ##
  # Mail [Notifier]
  #
  # The default delivery method for Mail Notifiers is 'SMTP'.
  # See the documentation for other delivery options.
  #
  # notify_by Ses do |ses|
  #   ses.on_success = false
  #   ses.on_warning = true
  #   ses.on_failure = true
  #
  #   ses.access_key_id = secrets["backup_aws_access_key_id"]
  #   ses.secret_access_key = secrets["backup_aws_secret_access_key_id"]
  #   ses.region = secrets["backup_s3_region"]
  #
  #   ses.from = secrets["backup_email_from"]
  #   ses.to = secrets["backup_email_to"]
  # end

end
