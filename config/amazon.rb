require 'amazon/ecs'

Amazon::Ecs.configure do |options|
  options[:AWS_access_key_id] = ENV["AMAZON_KEY"]
  options[:AWS_secret_key] = ENV["AMAZON_SECRET"]
  options[:associate_tag] = ENV["AMAZON_ASSOCIATE_TAG"]
end