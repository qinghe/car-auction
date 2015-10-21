require 'rails_helper'

describe PinganController, :type => :controller do
  let( :xml ){  File.read(File.expand_path('../../fixtures/car.xml', __FILE__)) }

    it "responds successfully with an HTTP 200 status code" do
      post 'create', { data: xml }
      expect(response).to be_success
            expect(response).to have_http_status(200)
    end

end
