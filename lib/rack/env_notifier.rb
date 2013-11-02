require 'rack/env_notifier/body_injector'

module Rack
  class EnvNotifier
    class << self
      def message
        @message
      end

      def message=(message)
        @message = message
      end

      def notification
        <<-EOF
<!-- Notify Start -->
<div id="env-notifier" class="#{@message.gsub(/[^a-z]/i, '-').gsub(/--*/, '-').gsub(/-$/, '')}" style="position: fixed; top: 0; right: 0; left: 0; background: rgba(150, 50, 50, .7); color: #fff; text-align: center; font-size: 16px; font-weight: bold; padding: 2px; z-index: 999999">#{@message}</div>
<!-- Notify End -->
        EOF
      end

      def notify?
        @notify
      end

      def notify=(notify)
        @notify = notify
      end
    end

    def initialize(app)
      @app = app
    end

    def call(env)
      dup._call(env)
    end

    def _call(env)
      status, headers, body = @app.call(env)

      # inject headers, notification
      if status == 200 and EnvNotifier.notify?

        # inject notification
        if headers['Content-Type'] =~ %r{text/html} then
          injector = BodyInjector.new(body, EnvNotifier.notification)
          injector.inject!(env)

          # inject header
          if injector.notification_added
            headers['X-EnvNotifier'] = EnvNotifier.message
          end

          headers['Content-Length'] = injector.content_length.to_s
          [status, headers, injector.new_body]
        end
        [status, headers, body]
      else
        [status, headers, body]
      end
    end
  end
end
