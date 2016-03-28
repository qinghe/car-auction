require 'rails_helper'

describe Pingan::QuotedPriceMessage do
  let!( :auction ) { create( :auction  ) }

  it "to json" do

    price_message =  Pingan::QuotedPriceMessage.new( auction )
    price_message.to_json.should =~/partnerAccount/

  end


end
