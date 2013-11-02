module EnvNotifierRails
  class Railtie < ::Rails::Railtie
    initializer 'rack_env_notifier.initialize' do |app|
      Rack::EnvNotifier.message = 'development'
      Rack::EnvNotifier.notify  = Rails.env.development?

      # Install the Middleware
      app.config.middleware.use Rack::EnvNotifier
    end
  end
end
