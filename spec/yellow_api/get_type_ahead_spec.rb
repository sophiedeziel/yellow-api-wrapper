require 'helper'

describe YellowApi::Client::GetTypeAhead do
  let(:apikey) { ENV["YELLOW_API_KEY"] }

  before do
    @client = YellowApi::Client.new(:apikey => apikey, uid: "asdf")
    @client.sandbox_enabled = true
  end

  describe ".get_type_ahead" do
    it "should return suggestions" do
      wait 2 do
        suggestions = @client.get_type_ahead("au", :what)
        suggestions.length.should > 0
      end
    end
  end
end
