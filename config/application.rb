require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module BookLibrary
  class Application < Rails::Application
    config.autoload_paths << Rails.root.join("lib")
    config.time_zone = 'Pacific Time (US & Canada)'
    config.action_mailer.default_url_options = { host: ENV['DEFAULT_URL'] }
  end
end
