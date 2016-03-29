require 'rails_helper'

describe Pingan::TransferInfoMessage do
  let!( :auction ) { create( :auction  ) }

  it "to json" do

    price_message =  Pingan::TransferInfoMessage.new( auction )
    price_message.to_json.should =~/partnerAccount/

  end

  it "should has fields" do
    price_message =  Pingan::TransferInfoMessage.new( auction )
    expect( price_message.to_hash.keys ).to match_array(Pingan::TransferInfoMessage.required_fileds)

  end

end
