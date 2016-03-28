require 'rails_helper'

describe Pingan::Connector do

  before( :each) {
    @administrator = create(:user, :administrator)
  }
  it 'should get token' do
    Pingan::Connector.get_token.should be_a OAuth2::AccessToken

    @administrator.reload

    @administrator.access_token.should be_present
  end

  context "Response to pingan" do
    let( :auction) { create(:auction)  }
    it 'should post a PriceMessage' do
      quoted_price_message = Pingan::QuotedPriceMessage.new( auction )
      quoted_price_message.post

    end
  end
end
