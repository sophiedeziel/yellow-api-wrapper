require 'helper'

describe YellowApi::Client do
  let(:apikey) { 'd34q3259tezev7rdjkfwhw7d' }

  subject { YellowApi::Client.new(apikey: apikey) }

  it 'has a uid' do
    expect(subject.uid).to_not be_nil
  end

  it 'accepts a id as param' do
    expect(YellowApi::Client.new(apikey: apikey, uid: 'asdf').uid).to eq 'asdf'
  end
end
