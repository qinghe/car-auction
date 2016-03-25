require 'rails_helper'

describe Pingan::Connector do
  before( :all ) {
    Pingan::Connector.client_id = 'P_DLHC_CLAIM'
    Pingan::Connector.client_secret = 'acn385tr'
  }

  before( :each) {
    @administrator = create(:user, :administrator)
  }
  it 'should get token' do
    Pingan::Connector.get_token.should be_a OAuth2::AccessToken

    @administrator.reload

    @administrator.access_token.should be_present
  end


end
