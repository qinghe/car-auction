require 'rails_helper'

describe Pingan::PriceMessageWrapper do

  it "to json" do

    price_message =  Pingan::PriceMessageWrapper.new( 1 )
    price_message.to_json.should =~/partnerAccount/
  end


end
