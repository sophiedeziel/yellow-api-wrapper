require 'helper'

describe YellowApi::Client::GetTypeAhead do

  let(:apikey) { "d34q3259tezev7rdjkfwhw7d" }

  before do
    @client = YellowApi::Client.new(:apikey => apikey)
    @client.endpoint = "http://api.sandbox.yellowapi.com/"
  end


  describe ".get_type_ahead" do
    before do
      WebMock.allow_net_connect!

      stub_get("GetTypeAhead/?apikey=#{apikey}&text=au&field=WHAT&UID=1").
        to_return(:status => 200, :body => fixture("get_type_ahead.json"))
    end

    it "should return suggestions" do
      wait 2 do
        suggestions = @client.get_type_ahead("au", :what)

        a_get("GetTypeAhead/?apikey=#{apikey}&text=au&field=WHAT&lang=en&fmt=JSON&UID=#{@client.uid}").
        should have_been_made

        suggestions.length.should > 0
      end
    end
  end
end
