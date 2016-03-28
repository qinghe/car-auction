require 'rails_helper'

describe Pingan::TransferInfoCheckParser do

  let!( :auction ) { create( :auction, serial_no: serial_no  ) }
  let( :serial_no) { "test-#{Time.now.to_i}" }
  let( :json ){  File.read(File.expand_path('../../fixtures/pingan/transfer_info_check.json', __FILE__)) }


  it "should entrust auction" do

    info_parser =  Pingan::TransferInfoCheckParser.new( json )

    allow(info_parser).to receive(:task_auction_no).and_return( auction.serial_no )

    result =  info_parser.perform
    expect(result.succeed).to be true
    expect(auction.reload.channel_transfer_result).to eq  Auction::FeedbackEnum.yes

  end

end
