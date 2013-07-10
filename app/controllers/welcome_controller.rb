#encoding: utf-8
class WelcomeController < ApplicationController
  layout 'frontend'
  def index

    @title = "事故车 - 拍卖 "

    @auctions = Auction.open.public_auctions.with_status(:active).order("start_at").paginate(:page => 1, :per_page => 10)

  end
end
