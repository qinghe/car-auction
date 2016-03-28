require 'rails_helper'

describe Pingan::EntrustedMessageParser do

  let!( :auction ) { create( :auction, serial_no: serial_no  ) }
  let( :serial_no) { "test-#{Time.now.to_i}" }
  let( :json ){  File.read(File.expand_path('../../fixtures/pingan/entrust.json', __FILE__)) }


  it "should entrust auction" do

    info_parser =  Pingan::EntrustedMessageParser.new( json )

    allow(info_parser).to receive(:task_auction_no).and_return( auction.serial_no )

    info_parser.attributes['isEntrust'] = Pingan::EntrustedMessageParser::EntrustingEnum.yes

    result =  info_parser.perform
    expect(result.succeed).to be true
    expect(auction.reload.is_entrust).to eq  Pingan::EntrustedMessageParser::EntrustingEnum.yes

  end

end
