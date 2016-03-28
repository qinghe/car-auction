require 'rails_helper'

describe Pingan::QuotedPriceResponse do
  let!( :auction ) { create( :auction  ) }

  it "to json" do

    price_message =  Pingan::QuotedPriceResponse.new( auction )
    price_message.to_json.should =~/partnerAccount/

  end


end
