require 'helper'

describe YellowApi::Client::GetBusinessDetails do
  let(:apikey) { ENV["YELLOW_API_KEY"] }

  before do
    @client = YellowApi::Client.new(:apikey => apikey, uid: "asdf")
    @client.sandbox_enabled = true
  end

  describe ".get_business_details" do
    it "should return the correct business" do
      wait 2 do
        business = @client.get_business_details("Ile-du-Prince-Edouard", "Co-operators-The", 6418182, {:city => "Calgary"})
        business.id.should == "6418182"
      end
    end
  end
end
