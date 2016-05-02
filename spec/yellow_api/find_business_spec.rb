require 'helper'

describe YellowApi::Client::FindBusiness do
  let(:apikey) { ENV["YELLOW_API_KEY"] }

  before do
    @client = YellowApi::Client.new(:apikey => apikey, uid: "asdf")
    @client.sandbox_enabled = true
  end

  describe ".find_business" do
    it "should return the correct number of businesses" do
      wait 2 do
        business = @client.find_business("barber", "Canada", { :pgLen => 1 })
        business.summary.listingsPerPage == 1
      end
    end
  end
end
