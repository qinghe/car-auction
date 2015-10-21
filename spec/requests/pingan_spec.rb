require 'rails_helper'

RSpec.describe "push car info", :type => :request do
  let( :xml ){  File.read(File.expand_path('../../fixtures/car.xml', __FILE__)) }

  it "responds successfully with an HTTP 200 status code" do
      post '/InsCarQuo/PingAn', { data: xml }
      expect(response).to be_success
            expect(response).to have_http_status(200)
  end

end
