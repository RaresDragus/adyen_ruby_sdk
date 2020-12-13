require 'spec_helper'

RSpec.describe Adyen::Connection do
  describe 'configuration' do
    it 'should include all configurations' do
      expect(described_class).to respond_to :config
      expect(described_class.config.client_key).to be
      expect(described_class.config.client_secret).to be
      expect(described_class.config.public_key).to be
      expect(described_class.config.endpoint).to be
      expect(described_class.config.merchant_account).to be
      expect(described_class.config.skin_code).to be
      expect(described_class.config.hmac_key).to be
    end
  end

  describe 'send_json_request' do
    it 'raise an error if receives Errno::ECONNRESET from Adyen server' do
      allow(described_class).to receive(:post).and_raise(Errno::ECONNRESET)
      expect do
        described_class.send(:send_json_request, 'Adyen::Common::Address', 'http://example.com')
      end.to raise_error(Adyen::Exceptions::Timeout)
    end

    it 'raise an error if receives RestClient::RequestTimeout from Adyen server' do
      allow(described_class).to receive(:post).and_raise(RestClient::Exceptions::Timeout)
      expect do
        described_class.send(:send_json_request, 'Adyen::Common::Address', 'http://example.com')
      end.to raise_error(Adyen::Exceptions::Timeout)
    end
  end

  context 'private methods' do
    describe 'api_headers' do
      let(:partial_headers) { { content_type: :json, accept: :json } }

      it "should have 'authorisation' key" do
        expect(described_class.send(:api_headers)).to have_key(:authorization)
      end

      it "should have 'content_type' and 'accept' values" do
        expect(partial_headers.to_a - described_class.send(:api_headers).to_a).to be_empty
      end
    end

    describe 'api_url' do
      it 'should return a proper URI' do
        expect(described_class.send(:api_url, :payment, 'authorise')).to eq(
          'https://pal-test.adyen.com/pal/servlet/Payment/v46/authorise'
        )
      end
    end

    describe 'basic_token' do
      it 'properly encodes the credentials' do
        expect(Base64.strict_decode64(described_class.send(:basic_token)).split(':')).to eq(
          [
            described_class.config.client_key,
            described_class.config.client_secret
          ]
        )
      end
    end

    describe 'auth_basic_header' do
      it 'uses the Basic method' do
        expect(described_class.send(:auth_basic_header).values.first).to start_with('Basic ')
      end
    end

    describe 'auth_header' do
      let(:method) { 'Basic' }
      let(:token)  { SecureRandom.hex }

      it 'is a hash' do
        expect(described_class.send(:auth_header, method, token)).to be_a(Hash)
      end

      it 'has one element' do
        expect(described_class.send(:auth_header, method, token).size).to eq(1)
      end

      it 'has the key Authorization' do
        expect(described_class.send(:auth_header, method, token)).to have_key(:authorization)
      end

      it 'contains the method' do
        expect(described_class.send(:auth_header, method, token).values.first).to start_with("#{method} ")
      end
    end

    describe 'content_type_json header' do
      it 'is a hash' do
        expect(described_class.send(:content_type_json_header)).to be_a(Hash)
      end

      it 'has one element' do
        expect(described_class.send(:content_type_json_header).size).to eq(1)
      end

      it 'has the key Content_Type' do
        expect(described_class.send(:content_type_json_header)).to have_key(:content_type)
      end

      it 'contains the JSON information' do
        expect(described_class.send(:content_type_json_header).values.first).to eq(:json)
      end
    end

    describe 'accept_json header' do
      it 'is a hash' do
        expect(described_class.send(:accept_json_header)).to be_a(Hash)
      end

      it 'has one element' do
        expect(described_class.send(:accept_json_header).size).to eq(1)
      end

      it 'has the key Accept' do
        expect(described_class.send(:accept_json_header)).to have_key(:accept)
      end

      it 'contains the JSON information' do
        expect(described_class.send(:accept_json_header).values.first).to eq(:json)
      end
    end

    describe 'process_response' do
      let(:bad_response)      { OpenStruct.new(code: 400) }
      let(:error_response)    { OpenStruct.new(code: 401) }
      let(:redirect_response) { OpenStruct.new(code: 302) }
      let(:response)          { OpenStruct.new(code: 200) }

      before do
        allow(described_class).to receive(:parse_errors)                            { build :service_exception }
        allow(described_class).to receive(:parse_object)                            { build(:address) }
        allow_any_instance_of(RestClient::Response).to receive(:follow_redirection) { nil }
        allow_any_instance_of(RestClient::Response).to receive(:return!)            { nil }
      end

      it "should return an Adyen object if the response's code is 200" do
        expect(described_class.send(:process_response, response, nil, nil)).to be_a(Adyen::Common::Address)
      end

      it "should follow redirection if the response's code is 302" do
        expect(described_class.send(:process_response, redirect_response, nil, nil)).to be nil
      end

      it "should return nil if the response's code is 400" do
        expect(described_class.send(:process_response, bad_response, nil, nil)).to be nil
      end

      it "should return nil if the response's code is 401" do
        expect(described_class.send(:process_response, bad_response, nil, nil)).to be nil
      end
    end

    describe 'accept_json_header' do
      it 'is a hash' do
        expect(described_class.send(:accept_json_header)).to be_a(Hash)
      end

      it 'has one element' do
        expect(described_class.send(:accept_json_header).size).to eq(1)
      end

      it 'has the key Accept' do
        expect(described_class.send(:accept_json_header).keys.first).to eq(:accept)
      end

      it 'contains the JSON information' do
        expect(described_class.send(:accept_json_header).values.first).to eq(:json)
      end
    end

    describe 'parse_object' do
      let(:response_without_body)    { OpenStruct.new }
      let(:response_with_empty_body) { OpenStruct.new(body: '') }
      let(:response) do
        OpenStruct.new(
          body: '{ "status" : "200", "errorCode" : "704", "message" : "request already processed", '\
                     '"errorType" : "validation"}'
        )
      end

      it 'should return true if response is without body' do
        expect(described_class.send(:parse_object, response_without_body)).to be true
      end

      it 'should return true if response has an empty body' do
        expect(described_class.send(:parse_object, response_with_empty_body)).to be true
      end

      it "should return a Hash if response's body is present" do
        expect(described_class.send(:parse_object, response)).to be_a Hash
      end
    end

    describe 'parse_errors' do
      let(:response_without_body)    { OpenStruct.new }
      let(:response_with_empty_body) { OpenStruct.new(body: '') }
      let(:error_response) do
        OpenStruct.new(
          body: '{ "status" : "422", "errorCode" : "704", "message" : "request already processed", '\
                     '"errorType" : "validation"}'
        )
      end

      it 'should return false if response is without body' do
        expect(described_class.send(:parse_errors, response_without_body)).to be false
      end

      it 'should return false if response has an empty body' do
        expect(described_class.send(:parse_errors, response_with_empty_body)).to be false
      end

      it "should return an Adyen::Common::ServiceException object if response's body is present" do
        expect(described_class.send(:parse_errors, error_response)).to be_a Adyen::Common::ServiceException
      end
    end
  end
end
