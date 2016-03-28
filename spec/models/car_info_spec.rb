require 'rails_helper'

describe Pingan::CarInquireInfoParser do

  let( :serial_no) { "test-#{Time.now.to_i}" }
  let( :json ){  File.read(File.expand_path('../../fixtures/pingan/car.json', __FILE__)) }

  it "should parse json to hash" do
    car_info_parser =  Pingan::CarInquireInfoParser.new( json )
    expect( car_info_parser.attributes ).to be_a Hash
  end

  it "create car info from json" do
    expected_serial_no = serial_no
    car_info_parser =  Pingan::CarInquireInfoParser.new( json )
    car_info_parser.attributes['taskAuctionNo'] = expected_serial_no

    expect{ car_info_parser.perform }.to change{Car.count}.by(1)

    #result = car_info_parser.perform
    Car.where( serial_no: expected_serial_no ).should be_exists
  end


end
