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
      expect(last_response).to be_ok
    end

    it 'has the X-EnvNotifier header' do
      expect(last_response.headers.has_key?('X-EnvNotifier')).to eq true
    end

    it 'has only one X-EnvNotifier header' do
      h = last_response.headers['X-EnvNotifier']
      expect(h).to eq('warning!!! hot zone!!!')
    end

    it 'has the Notification in the body' do
      expect(last_response.body.include?('<div id="env-notifier" class="warning-hot-zone" style="position: fixed; top: 0; right: 0; left: 0; background: rgba(150, 50, 50, .7); color: #fff; text-align: center; font-size: 16px; font-weight: bold; padding: 2px; z-index: 999999">warning!!! hot zone!!!</div>')).to eq true
    end

  end

  describe 'with a notify set on false' do

    before do
      Rack::EnvNotifier.message = 'warning!!!'
      Rack::EnvNotifier.notify = false
      get '/some/path'
    end

    it 'returns 200' do
      expect(last_response).to be_ok
    end

    it 'has the X-EnvNotifier header' do
      expect(last_response.headers.has_key?('X-EnvNotifier')).not_to eq true
    end

    it 'has the Notification in the body' do
      expect(last_response.body.include?('<div id="env-notifier" class="warning" style="position: fixed; top: 0; right: 0; left: 0; background: rgba(150, 50, 50, .7); color: #fff; text-align: center; font-size: 16px; font-weight: bold; padding: 2px; z-index: 999999">warning</div>')).not_to eq true
    end

  end

  describe 'Notification format' do
    before do
      Rack::EnvNotifier.message = 'notification'
      get '/some/path'
    end

    describe "with default CSS" do
      it "does format the Notification" do
        expect(Rack::EnvNotifier.notification).to eq(<<-EOF
<!-- Notify Start -->
<div id="env-notifier" class="notification" style="position: fixed; top: 0; right: 0; left: 0; background: rgba(150, 50, 50, .7); color: #fff; text-align: center; font-size: 16px; font-weight: bold; padding: 2px; z-index: 999999">notification</div>
<!-- Notify End -->
        EOF
        )
      end
    end

    context "with custom CSS" do
      before do
        Rack::EnvNotifier.custom_css = true
      end

      it "does format the Notification" do
        expect(Rack::EnvNotifier.notification).to eq(<<-EOF
<!-- Notify Start -->
<div id="env-notifier" class="notification">notification</div>
<!-- Notify End -->
        EOF
        )
      end
    end
  end
end
