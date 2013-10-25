# EnvNotifier

Middleware that displays the current Environment notification for every html page. Designed to work both in production and in development.

![alt tag](https://raw.github.com/ducknorris/env_notifier/master/assets/preview1.png)

![alt tag](https://raw.github.com/ducknorris/env_notifier/master/assets/preview2.png)

![alt tag](https://raw.github.com/ducknorris/env_notifier/master/assets/preview3.png)

![alt tag](https://raw.github.com/ducknorris/env_notifier/master/assets/preview4.png)

![alt tag](https://raw.github.com/ducknorris/env_notifier/master/assets/preview5.png)

![alt tag](https://raw.github.com/ducknorris/env_notifier/master/assets/preview6.png)

![alt tag](https://raw.github.com/ducknorris/env_notifier/master/assets/preview7.png)

## Installation

Add this line to your application's Gemfile:

    gem 'env_notifier'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install env_notifier

## Usage

This Gem is working out of the box in development environment.

For all environments configure an initializer like so:

    Rack::EnvNotifier.config.authorize_environment = lambda {|env| true }

Or just for production environment:

    Rack::EnvNotifier.config.authorize_environment = lambda {|env| true } if Rails.env.production?

### There are several configuration options

#### Position on screen

    Rack::EnvNotifier.config.position_on_screen = "top"

Available options are: top, right, bottom, left.

#### Notification message

    Rack::EnvNotifier.config.notification_message = "development"

By default the message it will be the name of the current environment. This can be overriden like so:

    case Rails.env
    when "development"
      Rack::EnvNotifier.config.notification_message = "safe environment"
    when "staging"
      Rack::EnvNotifier.config.notification_message = "qa environment"
    else
      Rack::EnvNotifier.config.notification_message = "hot environment"
    end

The notification uses ``#env-notifer`` CSS ID. This can be customized further on, using custom CSS.

    #env-notifier {
      font-size: 16px;
    }

    #env-notifier.development {
      background: #369;
      color: #fff;
    }

    #env-notifier.production {
      background: #8a0000;
      color: #fff;
      font-weight: bold;
    }

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
