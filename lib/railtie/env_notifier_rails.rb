module EnvNotifierRails
  class Railtie < ::Rails::Railtie
    initializer "rack_env_notifier.configure_rails_initialization" do |app|
      # Install the Middleware
      app.middleware.insert(0, Rack::EnvNotifier)
      Rack::EnvNotifier.message = Rails.env
    end
  end
end
