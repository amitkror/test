# Load the rails application
require File.expand_path('../application', __FILE__)

# Set our CONFIG constant
CONFIG = YAML.load_file("#{Rails.root}/config/nyccollegeline.yml")[Rails.env]

# Initialize the rails application
NycCollegeLine::Application.initialize!
