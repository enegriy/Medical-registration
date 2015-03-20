
# Load the rails application
require File.expand_path('../application', __FILE__)

aEnv = ["development", "test", "production"]
Rails.env=aEnv[0]

# Initialize the rails application
Intreg::Application.initialize!

