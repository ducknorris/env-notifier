require 'rack/env_notifier/body_injector'

module Rack
  class EnvNotifier
    class << self
      def custom_css
        @custom_css
      end

      def custom_css=(css)
        @custom_css = css
      end

      def message
        @message
      end

      def message=(msg)
        @message = msg
      end

      def notification
        if @custom_css == true
          <<-EOF
<!-- Notify Start -->
<div id="env-notifier" class="#{@message.gsub(/[^a-z]/i, '-').gsub(/--*/, '-').gsub(/-$/, '')}">#{@message}</div>
<!-- Notify End -->
          EOF
        else
          <<-EOF
<!-- Notify Start -->
<div id="env-notifier" class="#{@message.gsub(/[^a-z]/i, '-').gsub(/--*/, '-').gsub(/-$/, '')}" style="position: fixed; top: 0; right: 0; left: 0; background: rgba(150, 50, 50, .7); color: #fff; text-align: center; font-size: 16px; font-weight: bold; padding: 2px; z-index: 999999">#{@message}</div>
<!-- Notify End -->
          EOF
        end
      end

      def notify?
        @notify
      end

      def notify=(ntf)
        @notify = ntf
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
