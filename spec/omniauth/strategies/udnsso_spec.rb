require 'spec_helper'

describe OmniAuth::Strategies::Udnsso do
  let(:access_token) { double(:openid => "open_id", :access_token => "access_token") }


  let(:parsed_response) { double('ParsedResponse') }
  let(:response) { double('Response', :parsed => parsed_response) }

  subject do
    OmniAuth::Strategies::Udnsso.new({})
  end

  before(:each) do
    subject.stub(:access_token).and_return(access_token)
  end

  context "client options" do
    it 'should have correct site' do
      subject.options.client_options.site.should eq("http://udn.yyuap.com/")
    end

    it 'should have correct authorize url' do
      subject.options.client_options.authorize_url.should eq('http://udn.yyuap.com/sso/admin.php/Home/Public/login')
    end

    it 'should have correct token url' do
      subject.options.client_options.token_url.should eq('http://udn.yyuap.com/sso/admin.php/Home/Token/getToken/')
    end
  end

  context "#raw_info" do
    it "should get user info" do
      access_token.stub("[]") do |key|
        "some value"
      end

      access_token.should_receive(:get).and_return(response)
      subject.raw_info.should eq(parsed_response)
    end
  end
end