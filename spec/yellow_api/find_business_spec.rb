require 'helper'

describe YellowApi::Client::FindBusiness do
  let(:apikey) { "d34q3259tezev7rdjkfwhw7d" }

  before do
    @client = YellowApi::Client.new(:apikey => apikey, uid: "asdf")
    @client.sandbox_enabled = true
  end

  describe ".find_business" do
    before do
      WebMock.allow_net_connect!

      stub_get("FindBusiness/?what=barber&where=Canada&fmt=JSON&pgLen=10&apikey=#{apikey}&UID=#{@client.uid}").
        to_return(:status => 200, :body => fixture("find_business.json"))
    end

    it "should return the correct number of businesses" do
      wait 2 do
        business = @client.find_business("barber", "Canada", { :pgLen => 1 })
        a_get("FindBusiness/?what=barber&where=Canada&fmt=JSON&pgLen=1&apikey=#{apikey}&UID=#{@client.uid}").
          should have_been_made
        business.summary.listingsPerPage == 1
      end
    end
  end
end
