require 'rails_helper'

describe Pingan::CarInfo do
  let( :xml ){  File.read(File.expand_path('../../fixtures/car.xml', __FILE__)) }

  it "instance load info from xml" do
    data =  { taskAuctionNo: 'taskAuctionNo', modelName: 'modelName' }

    car =  Pingan::CarInfo.new
    car.from_xml( data.to_xml )

    car.taskAuctionNo.should eq 'taskAuctionNo'
  end


end
