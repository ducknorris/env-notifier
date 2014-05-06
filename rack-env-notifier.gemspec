# encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rack-env-notifier'

Gem::Specification.new do |spec|
  spec.name             = "rack-env-notifier"
  spec.version          = Rack::EnvNotifier::VERSION
  spec.authors          = ["Catalin Ilinca"]
  spec.email            = ["c@talin.ro"]
  spec.description      = %q{Middleware that displays the custom notification for every html page. Designed to work both in production and in development.}
  spec.summary          = %q{Know your ground!}
  spec.homepage         = "https://github.com/ducknorris/rack-env-notifier"
  spec.license          = "MIT"
  spec.extra_rdoc_files = [
    "README.md",
    "CHANGELOG.md"
  ]

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"

  spec.add_development_dependency "rack-test"

  spec.add_runtime_dependency 'rack', '>= 1.1.3'
end
