require File.expand_path('../boot', __FILE__)

require 'active_model/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'sprockets/railtie'

Bundler.require(*Rails.groups)
module BookLibrary
  class Application < Rails::Application
    config.autoload_paths << "#{Rails.root}/lib"
    config.time_zone = 'Pacific Time (US & Canada)'
    config.action_mailer.default_url_options = { host: ENV['DEFAULT_URL'] }
  end
end
