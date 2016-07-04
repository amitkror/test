unless defined?(CONFIG)
  CONFIG = YAML.load_file("#{Rails.root}/config/nyccollegeline.yml")[Rails.env]
end

# Switching to aws-sdk for bcc support
#ActionMailer::Base.add_delivery_method :ses, AWS::SES::Base,
#  access_key_id: CONFIG['aws_access_key_id'],
#  secret_access_key: CONFIG['aws_secret_access_key']

AWS.config(
  access_key_id: CONFIG['aws_access_key_id'],
  secret_access_key: CONFIG['aws_secret_access_key']
)