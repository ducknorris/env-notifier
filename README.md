# Rack::EnvNotifier [![Build Status](https://secure.travis-ci.org/ducknorris/rack-env-notifier.png)](http://travis-ci.org/ducknorris/rack-env-notifier)

[![Code Climate](https://codeclimate.com/github/ducknorris/rack-env-notifier.png)](https://codeclimate.com/github/ducknorris/rack-env-notifier) [![Dependency Status](https://gemnasium.com/ducknorris/rack-env-notifier.png)](https://gemnasium.com/ducknorris/rack-env-notifier) [![Gem Version](https://badge.fury.io/rb/rack-env-notifier.png)](http://badge.fury.io/rb/rack-env-notifier)

Middleware that displays the custom notification for every html page. Designed to work both in production and in development.

## Installation

Add this line to your application's Gemfile:

    gem 'rack-env-notifier'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rack-env-notifier

## Usage

For Rails add use the middleware in application.rb:

    config.middleware.use Rack::EnvNotifier


Rack::EnvNotifier can display a custom notification on every html page. It can be configured:

    Rack::EnvNotifier.notify = Rails.env.production?

or

    Rack::EnvNotifier.notify = true if ["12.34.56.78", "127.0.0.1"].include?(request.remote_ip)

### There are several configuration options

#### Position on screen

The notification message is wrapped by ``#env-notifer`` CSS ID. This can be customized using custom CSS.

To disable default CSS and use a custom one, configure the initializer:

    Rack::EnvNotifier.custom_css = true

and define the custom CSS:

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

The default message is configured in the initializer:

    case Rails.env
    when "development"
      Rack::EnvNotifier.message = "safe environment"
    when "staging"
      Rack::EnvNotifier.message = "qa environment"
    else
      Rack::EnvNotifier.message = "hot environment"
    end


### Rails Sample Initializer

    if Rails.env.development?
      Rack::EnvNotifier.notify = true
      Rack::EnvNotifier.message = 'Dev'
    end

## Preview

![alt tag](https://rack-env-notifier.s3.amazonaws.com/assets/preview1.png)

![alt tag](https://rack-env-notifier.s3.amazonaws.com/assets/preview2.png)

![alt tag](https://rack-env-notifier.s3.amazonaws.com/assets/preview3.png)

![alt tag](https://rack-env-notifier.s3.amazonaws.com/assets/preview4.png)

![alt tag](https://rack-env-notifier.s3.amazonaws.com/assets/preview5.png)

![alt tag](https://rack-env-notifier.s3.amazonaws.com/assets/preview6.png)

![alt tag](https://rack-env-notifier.s3.amazonaws.com/assets/preview7.png)

## Contributing

Thanks to our [contributors](https://github.com/ducknorris/rack-env-notifier/graphs/contributors).

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

#### Inspired by [harleyttd / miniprofiler](https://github.com/harleyttd/miniprofiler/).
