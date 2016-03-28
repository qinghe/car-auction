require 'rails_helper'

describe Pingan::QuotedPriceAgainMessage do
  let!( :auction ) { create( :auction  ) }

  it "to json" do

    price_message =  Pingan::QuotedPriceAgainMessage.new( auction )
    price_message.to_json.should =~/partnerAccount/

  end


end
