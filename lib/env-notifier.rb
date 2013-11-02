require 'rack/env_notifier'
require 'railtie' if defined? Rails

class Rack::EnvNotifier
  VERSION = "0.0.1"
end
