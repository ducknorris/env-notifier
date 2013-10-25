# EnvNotifier [![Build Status](https://secure.travis-ci.org/ducknorris/env_notifier.png)](http://travis-ci.org/ducknorris/env_notifier)

Middleware that displays the custom environment notification for every html page. Designed to work both in production and in development.

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

This Gem will display a custom notification on every html page.

    Rack::EnvNotifier.config.notify? = lambda {|env| Rails.env.development? }

### There are several configuration options

#### Position on screen

    Rack::EnvNotifier.config.position = "top"

Available options are: top, right, bottom, left.

#### Notification message

    Rack::EnvNotifier.config.notification_message = "development"

For Ruby on Rails, by default the message it will be the name of the current environment. This can be overriden like so:

    case Rails.env
    when "development"
      Rack::EnvNotifier.config.message = "safe environment"
    when "staging"
      Rack::EnvNotifier.config.message = "qa environment"
    else
      Rack::EnvNotifier.config.message = "hot environment"
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

Thanks to our [contributors](https://github.com/ducknorris/env_notifier/graphs/contributors).

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

#### Inspired by [harleyttd / miniprofiler](https://github.com/harleyttd/miniprofiler/)
