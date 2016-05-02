require 'helper'

RSpec.describe YellowApi::Client::GetBusinessDetails do
  let(:apikey) { ENV['YELLOW_API_KEY'] }

  before do
    @client = YellowApi::Client.new(apikey: apikey, uid: 'asdf')
    @client.sandbox_enabled = true
  end

  describe '.get_business_details' do
    subject { @client.get_business_details('Ile-du-Prince-Edouard', 'Co-operators-The', 6_418_182, city: 'Calgary') }
    it 'returns the correct business' do
      expect(subject.id).to eq '6418182'
    end

    it 'returns the correct format' do
      expect(subject).to be_a Hash
    end
  end
end
