require 'rails_helper'

RSpec.describe "Pingan", :type => :request do
  let( :json ){  File.read(File.expand_path('../../fixtures/pingan/car.json', __FILE__)) }

  it "get task name" do
    post '/InsCarQuo/PingAn/sendCarInquireInfo' ,  json
    expect(assigns(:task)).to eq 'sendCarInquireInfo'
  end

  it "push car info" do
      post '/InsCarQuo/PingAn/sendCarInquireInfo' ,  json

      expect(response).to be_success
      expect(response).to have_http_status(200)
  end

end
