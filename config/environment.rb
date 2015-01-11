# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
    :user_name => ENV["SENDGRID_USERNAME"],
    :password => ENV["SENDGRID_PASSWORD"],
    :domain => ENV["SENDGRID_DOMAIN"],
    :address => 'smtp.sendgrid.net',
    :port => 587,
    :authentication => :plain,
    :enable_starttls_auto => true
  }

Amazon::Ecs.options = {
 associate_tag: ENV['AMAZON_ASSOCIATE_TAG'],
 AWS_access_key_id: ENV['AMAZON_KEY_ID'],
 AWS_secret_key: ENV['AMAZON_SECRET_ID']
}
