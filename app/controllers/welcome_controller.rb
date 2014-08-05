#encoding: utf-8
class WelcomeController < ApplicationController
  layout 'frontend'
  skip_before_filter :authenticate
  
  def index
    @title = ""
    @auctions = Auction.open.public_auctions.with_status(:active).order("start_at").paginate(:page => 1, :per_page => 10)
  end

  def search_car
    @title = "查找拍卖车辆"
    @auctions = Auction.open.public_auctions.with_status(:active).order("start_at").paginate(:page => 1, :per_page => 10)
  end

end
