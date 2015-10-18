require 'rails_helper'

describe PinganController, :type => :controller do

    it "responds successfully with an HTTP 200 status code" do
      post 'create'
      expect(response).to be_success
            expect(response).to have_http_status(200)
    end

end
