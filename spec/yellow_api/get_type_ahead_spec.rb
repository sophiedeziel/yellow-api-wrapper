require 'helper'

describe YellowApi::Client::GetTypeAhead do
  let(:apikey) { ENV['YELLOW_API_KEY'] }

  before do
    @client = YellowApi::Client.new(apikey: apikey, uid: 'asdf')
    @client.sandbox_enabled = true
  end

  describe '.get_type_ahead' do
    subject { @client.get_type_ahead('au', :what) }
    it 'should return suggestions' do
      expect(subject.length).to be > 0
    end

    it { is_expected.to be_a Hash }
  end
end
