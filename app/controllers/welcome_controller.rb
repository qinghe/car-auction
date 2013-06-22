#encoding: utf-8
class WelcomeController < ApplicationController
  layout 'frontend'
  def index

    @title = "事故车 - 拍卖 "

    @auctions = Auction.where(["car_id>0"]).open.public_auctions.with_status(:active).order("id DESC").paginate(:page => 1, :per_page => 10)

  end
end
