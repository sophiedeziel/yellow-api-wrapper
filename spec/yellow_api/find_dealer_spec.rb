require 'helper'

describe YellowApi::Client::FindDealer do
  let(:apikey) { ENV["YELLOW_API_KEY"] }

  before do
    @client = YellowApi::Client.new(:apikey => apikey, uid: "asdf")
    @client.sandbox_enabled = true
  end

  describe ".find_dealer" do
    it "should return the correct parent business" do
      wait 2 do
        business = @client.find_dealer(6418182, {:pgLen => 1})
        business.listings.first.parentId == "6418182"
      end
    end
  end
end
