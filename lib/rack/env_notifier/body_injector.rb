module Rack
  class EnvNotifier
    class BodyInjector
      BODY_TAG_REGEX = /<body>|<body[^(er)][^<]*>/

      attr_reader :content_length, :new_body, :notification_added

      def initialize(body, text_to_be_injected)
        @body                = body
        @text_to_be_injected = text_to_be_injected
      end

      def inject!(env)
        @env = env
        @body.close if @body.respond_to?(:close)

        @body = [@body] if @body.is_a? String

        @new_body = []
        @body.each { |line| @new_body << line.to_s }

        @content_length     = 0
        @notification_added = false

        @new_body.each do |line|
          if !@notification_added && line['<body']
            line.gsub! (BODY_TAG_REGEX) {|match| %{{match}\n#{@text_to_be_injected}} }

            @notification_added = true
          end

          @content_length += line.bytesize
        end
        @new_body = @body
      end
    end
  end
end
