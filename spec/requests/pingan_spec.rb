require 'rails_helper'

RSpec.describe "Pingan", :type => :request do
  let( :xml ){  File.read(File.expand_path('../../fixtures/car.xml', __FILE__)) }

  it "push car info" do
      post '/InsCarQuo/PingAn' ,  data: xml
      expect(response).to be_success
      expect(response).to have_http_status(200)
  end

end
