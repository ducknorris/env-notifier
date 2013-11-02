# EnvNotifier [![Build Status](https://secure.travis-ci.org/ducknorris/env-notifier.png)](http://travis-ci.org/ducknorris/env-notifier) [![Code Climate](https://codeclimate.com/github/ducknorris/env-notifier.png)](https://codeclimate.com/github/ducknorris/env-notifier.png)

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

This Gem will display a custom notification on every html page. By default it will only work on Development Environment. This can be overriden like so:

    Rack::EnvNotifier.notify? = Rails.env.production?

or

    Rack::EnvNotifier.notify? = true if ["12.34.56.78", "127.0.0.1"].include?(request.remote_ip)

### There are several configuration options

#### Position on screen

Even though the "default" position is at the top of the page, the notification uses ``#env-notifer`` CSS ID. This can be customized further on, using custom CSS.

    #env-notifier {
      font-size: 16px;
    }

    /* Rack::EnvNotifier.message = 'development' */

    #env-notifier.development {
      background: #369;
      color: #fff;
    }

    /* Rack::EnvNotifier.message = 'watch out! production environment!!!' */

    #env-notifier.watch-out-production-environment {
      background: #8a0000;
      color: #fff;
      font-weight: bold;
    }


#### Notification message

    Rack::EnvNotifier.message = "development mode"

For Ruby on Rails, by default the message it will be the name of the current environment. This can be overriden like so:

    case Rails.env
    when "development"
      Rack::EnvNotifier.message = "safe environment"
    when "staging"
      Rack::EnvNotifier.message = "qa environment"
    else
      Rack::EnvNotifier.message = "hot environment"
    end

## Contributing

Thanks to our [contributors](https://github.com/ducknorris/env_notifier/graphs/contributors).

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

#### Inspired by [harleyttd / miniprofiler](https://github.com/harleyttd/miniprofiler/)
