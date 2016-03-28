require 'rails_helper'

describe Pingan::MultiInquireFeedbackHandler do

  let!( :auction ) { create( :auction, serial_no: serial_no  ) }
  let( :serial_no) { "test-#{Time.now.to_i}" }
  let( :json ){  File.read(File.expand_path('../../fixtures/pingan/multi_inquire_feedback.json', __FILE__)) }


  it "should entrust auction" do

    info_parser =  Pingan::MultiInquireFeedbackHandler.new( json )

    allow(info_parser).to receive(:task_auction_no).and_return( auction.serial_no )

    result =  info_parser.perform
    expect(result.succeed).to be true
    expect(auction.reload.inquire_result).to eq  Auction::FeedbackEnum.yes

  end

end
