require "env_notifier/version"

module Rack
  class EnvNotifier
    class << self
      def notification
        <<-EOF
<!-- Safety first -->
<div id="env-notifier" style="position: fixed; top: 0; right: 0; left: 0; background: rgba(150, 50, 50, .7); color: #fff; text-align: center; font-size: 16px; font-weight: bold; padding: 2px; z-index: 999999">DEVELOPMENT MODE</div>
<!-- Now we're save on dev mode -->
        EOF
      end
    end

    def initialize(app)
      @app = app
    end

    def call(env)
      status, headers, body = @app.call(env)

      # inject headers, notification
      if status == 200

        # inject header
        if headers.is_a? Hash
          headers['X-EnvNotifier'] = 'development'
        end

        # inject notification
        if headers.has_key?('Content-Type') && !headers['Content-Type'].match(/text\/html/).nil? then
          body << EnvNotifier.notification
        end
      end

      [status, headers, body]
    end
  end
end
