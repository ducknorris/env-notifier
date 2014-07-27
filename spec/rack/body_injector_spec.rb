require 'spec_helper'

describe Rack::EnvNotifier::BodyInjector do
  describe 'body tag regex' do
    let(:regex) { described_class::BODY_TAG_REGEX }
    subject { regex }

    it { should be_kind_of(Regexp) }

    it 'only picks a valid <body> tag' do
      expect(regex.match("<body></body>").to_s).to eq('<body>')
      expect(regex.match("<body><h1></h1></body>").to_s).to eq('<body>')
      expect(regex.match("<body attribute='something'><h1></h1></body>").to_s).to eq("<body attribute='something'>")
    end

    it 'responds nil when no head tag' do
      expect(regex.match("<html></html>")).to eq nil
    end
  end
end
