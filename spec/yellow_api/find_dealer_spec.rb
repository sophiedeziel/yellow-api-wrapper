require 'helper'

describe YellowApi::Client::FindDealer do
  let(:apikey) { ENV['YELLOW_API_KEY'] }

  before do
    @client = YellowApi::Client.new(apikey: apikey, uid: 'asdf')
    @client.sandbox_enabled = true
  end

  describe '.find_dealer' do
    subject { @client.find_dealer(6_418_182, pgLen: 1) }

    it 'should return the correct parent business' do
      expect(subject.listings.first.parentId).to eq '6418182'
    end

    it { is_expected.to be_a Hash }
  end
end
