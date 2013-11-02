require 'spec_helper'

describe Rack::EnvNotifier do
  include Rack::Test::Methods

  def app
    @app ||= Rack::Builder.new {
      use Rack::EnvNotifier
      map '/some/path' do
        run lambda { |env| [200, {'Content-Type' => 'text/html'}, <<-EOF
<html>
  <head>
    <title>Test page</title>
  </head>
  <body>
    <h1>Howdy</h1>
  </body>
</html>
          EOF
        ]}
      end
    }.to_app
  end

  describe 'with a notify set on true' do

    before do
      Rack::EnvNotifier.message = 'warning!!! hot zone!!!'
      Rack::EnvNotifier.notify = true
      get '/some/path'
    end

    it 'returns 200' do
      last_response.should be_ok
    end

    it 'has the X-EnvNotifier header' do
      last_response.headers.has_key?('X-EnvNotifier').should be_true
    end

    it 'has only one X-EnvNotifier header' do
      h = last_response.headers['X-EnvNotifier']
      h.should eq('warning!!! hot zone!!!')
    end

    it 'has the Notification in the body' do
      last_response.body.include?('<div id="env-notifier" class="warning-hot-zone" style="position: fixed; top: 0; right: 0; left: 0; background: rgba(150, 50, 50, .7); color: #fff; text-align: center; font-size: 16px; font-weight: bold; padding: 2px; z-index: 999999">warning!!! hot zone!!!</div>').should be_true
    end

  end

  describe 'with a notify set on false' do

    before do
      Rack::EnvNotifier.message = 'warning!!!'
      Rack::EnvNotifier.notify = false
      get '/some/path'
    end

    it 'returns 200' do
      last_response.should be_ok
    end

    it 'has the X-EnvNotifier header' do
      last_response.headers.has_key?('X-EnvNotifier').should_not be_true
    end

    it 'has the Notification in the body' do
      last_response.body.include?('<div id="env-notifier" class="warning" style="position: fixed; top: 0; right: 0; left: 0; background: rgba(150, 50, 50, .7); color: #fff; text-align: center; font-size: 16px; font-weight: bold; padding: 2px; z-index: 999999">warning</div>').should_not be_true
    end

  end

  describe 'Notification format' do
    before do
      Rack::EnvNotifier.message = 'notification'
      get '/some/path'
    end

    it "does format the Notification" do
      Rack::EnvNotifier.notification.should eq(<<-EOF
<!-- Notify Start -->
<div id="env-notifier" class="notification" style="position: fixed; top: 0; right: 0; left: 0; background: rgba(150, 50, 50, .7); color: #fff; text-align: center; font-size: 16px; font-weight: bold; padding: 2px; z-index: 999999">notification</div>
<!-- Notify End -->
      EOF
      )
    end
  end
end
