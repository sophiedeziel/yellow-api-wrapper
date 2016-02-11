require 'helper'

describe YellowApi::Client::FindDealer do

  let(:apikey) { "d34q3259tezev7rdjkfwhw7d" }

  before do
    @client = YellowApi::Client.new(:apikey => apikey)
    @client.sandbox_enabled = true
  end

  describe ".find_dealer" do
    before do
      WebMock.allow_net_connect!

      stub_get("FindDealer/?pid=6418182&fmt=JSON&apikey=#{apikey}&UID=1").
        to_return(:status => 200, :body => fixture("find_dealer.json"))
    end

    it "should return the correct parent business" do
      wait 2 do
        business = @client.find_dealer(6418182, {:pgLen => 1})
        a_get("FindDealer/?pid=6418182&apikey=#{apikey}&fmt=JSON&pgLen=1&UID=#{@client.uid}").
          should have_been_made
        business.listings.first.parentId == "6418182"
      end
    end
  end

end
