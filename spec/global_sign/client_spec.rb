require 'spec_helper'

describe GlobalSign::Client do
  let(:client) { GlobalSign::Client.new }

  describe '#initialize' do
    it 'has required object instances' do
      expect(client.instance_variable_get(:@configuration)).to be_a(GlobalSign::Configuration)
      expect(client.instance_variable_get(:@connection)).to be_a(Faraday::Connection)
    end
  end

  describe '#process' do
    context 'when received wrong parameter' do
      let(:wrong_class_request) { Class.new }

      it 'raises ArgumentError' do
        expect {
          client.process(wrong_class_request)
        }.to raise_error(ArgumentError)
      end
    end
  end

  describe '#find_response_class_for' do
    context 'when received url_verification' do
      let(:url_verification_request) do
        GlobalSign::UrlVerification::Request.new(
          order_kind:             'new',
          validity_period_months: 1,
          csr:                    'xxxxx',
        )
      end

      it 'returns the response class corresponding to the request class' do
        expect(client.find_response_class_for(url_verification_request)).to eq(GlobalSign::UrlVerification::Response)
      end
    end

    context 'when received wrong parameter' do
      let(:wrong_class_request) { Class.new }

      it 'raises ArgumentError' do
        expect {
          client.process(wrong_class_request)
        }.to raise_error(ArgumentError)
      end
    end
  end
end