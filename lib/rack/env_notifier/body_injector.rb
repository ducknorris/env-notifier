module Rack
  class EnvNotifier
    class BodyInjector
      # Lookup for <body> tag and inject notification after

      BODY_TAG_REGEX = /<body>|<body[^(er)][^<]*>/

      attr_reader :content_length, :new_body, :notification_added

      def initialize(body, text_to_be_injected)
        @body                = body
        @text_to_be_injected = text_to_be_injected
      end

      def inject!(env)
        @env = env
        @body.close if @body.respond_to?(:close)

        # Convert String body to Array so it can respond to each method
        # In test environment body may be a String object

        @body = [@body] if @body.is_a? String

        @new_body = []
        @body.each { |line| @new_body << line.to_s }

        @content_length     = 0
        @notification_added = false

        @new_body.each do |line|
          if !@notification_added && line['<body']
            line.gsub! (BODY_TAG_REGEX) {|match| %{#{match}\n#{@text_to_be_injected}} }

            @notification_added = true
          end

          # Keep track of content_length

          @content_length += line.bytesize
        end
        @new_body = @body
      end
    end
  end
end
