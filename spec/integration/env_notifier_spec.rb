# encoding: utf-8
require 'spec_helper'

describe Rack::EnvNotifier do
  include Rack::Test::Methods

  def app
    @app ||= Rack::Builder.new {
      use Rack::EnvNotifier
      map '/some/path' do
        run lambda { |env| [200, {'Content-Type' => 'text/html'}, '<h1>Howdy</h1>'] }
      end
    }.to_app
  end

  describe 'with a valid request' do

    before do
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
      h.should eq('development')
    end

    it 'has the Notification in the body' do
      last_response.body.include?('<div id="env-notifier" style="position: fixed; top: 0; right: 0; left: 0; background: rgba(150, 50, 50, .7); color: #fff; text-align: center; font-size: 16px; font-weight: bold; padding: 2px; z-index: 999999">').should be_true
    end

  end

  describe 'Notification format' do

    it "does format the Notification" do
      Rack::EnvNotifier.notification.should eq(<<-EOF
<!-- Safety first -->
<div id="env-notifier" style="position: fixed; top: 0; right: 0; left: 0; background: rgba(150, 50, 50, .7); color: #fff; text-align: center; font-size: 16px; font-weight: bold; padding: 2px; z-index: 999999">DEVELOPMENT MODE</div>
<!-- Now we're save on dev mode -->
      EOF
      )
    end

  end
end
