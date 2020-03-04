require_relative 'boot'
require 'rails/all'

Bundler.require(*Rails.groups)

module PortalSolarDevTest
  class Application < Rails::Application
    config.load_defaults 5.2
    config.assets.paths << Rails.root.join('app', 'assets', 'fonts')

    config.before_configuration do
      env_file = File.join(Rails.root + 'config/local_env.yml')
      YAML.load(File.open(env_file)).each do |key, value|
        ENV[key.to_s] = value
      end if File.exist?(env_file)
    end
  end
end
