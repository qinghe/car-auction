require 'rails_helper'

describe Pingan::QuotedPriceResponse do

  it "to json" do

    price_message =  Pingan::QuotedPriceResponse.new( 1 )
    price_message.to_json.should =~/partnerAccount/
  end


end
