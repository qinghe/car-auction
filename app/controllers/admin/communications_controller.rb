module Admin
  class CommunicationsController < BaseController

    def destroy
      @id = params[:id]
      @flash = flash_t
      Communication.find(@id).destroy
    end
  end
end
