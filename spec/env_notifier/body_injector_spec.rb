require 'spec_helper'

describe Rack::EnvNotifier::BodyInjector do
  describe 'body tag regex' do
    let(:regex) { described_class::BODY_TAG_REGEX }
    subject { regex }

    it { should be_kind_of(Regexp) }

    it 'only picks a valid <body> tag' do
      regex.match("<body></body>").to_s.should eq('<body>')
      regex.match("<body><h1></h1></body>").to_s.should eq('<body>')
      regex.match("<body attribute='something'><h1></h1></body>").to_s.should eq("<body attribute='something'>")
    end

    it 'responds false when no head tag' do
      regex.match("<html></html>").should be_false
    end
  end
end
