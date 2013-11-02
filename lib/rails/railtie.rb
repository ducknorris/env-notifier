module Rails
  class Railtie < Rails::Railtie
    initializer "rack_env_notifier.configure_rails_initialization" do |app|
      Rack::EnvNotifier.message = 'development'
      Rack::EnvNotifier.notify  = Rails.env.development?

      # Install the Middleware
      app.middleware.insert(0, Rack::EnvNotifier)
    end
  end
end
