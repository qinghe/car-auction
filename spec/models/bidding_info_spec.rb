require 'rails_helper'

describe Pingan::BiddingInfoParser do
  let!( :auction ) { create( :auction, serial_no: serial_no  ) }

  let( :serial_no) { "test-#{Time.now.to_i}" }
  let( :huachen) {  Pingan::Connector.client_name  }
  let( :json ){  File.read(File.expand_path('../../fixtures/pingan/bidding.json', __FILE__)) }


  it "should handle bidding" do

    info_parser =  Pingan::BiddingInfoParser.new( json )

    allow(info_parser).to receive(:task_auction_no).and_return( auction.serial_no )

    result =  info_parser.perform

    expect( result.succeed ).to be_present

  end

  it "should win bidding" do

    info_parser =  Pingan::BiddingInfoParser.new( json )

    allow(info_parser).to receive(:task_auction_no).and_return( auction.serial_no )

    info_parser.attributes['biddingUser'] = huachen

    result =  info_parser.perform

    expect( info_parser ).to be_win_bid
  end

end
