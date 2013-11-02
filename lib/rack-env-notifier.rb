require 'rack/env_notifier'
require 'rails/railtie' if defined? ::Rails

class Rack::EnvNotifier
  VERSION = "0.0.1"
end
