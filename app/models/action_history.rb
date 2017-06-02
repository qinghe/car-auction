class ActionHistory < ActiveRecord::Base
  belongs_to :auction

  def parsed_api_params
    @parsed_api_params ||= parse_json( api_params )
  end

  def parsed_api_result
    @parsed_api_result ||= parse_json( api_result )
  end

  def result_succeed?
    result['succeed'] == 'true'
  end

  def result_message
    result['message']
  end

  def result
    push_in_message? ? parsed_api_result : parsed_api_result['data']
  end


  def parse_json( data )
    begin
      ActiveSupport::JSON.decode(data)
    rescue ActiveSupport::JSON.parse_error
      Rails.logger.warn("Attempted to decode invalid JSON: #{data}")
      {}
    end
  end

  def to_formatted_s
    case self.api_name
     when '/InsCarQuo/PingAn/sendCarInquireInfo'
       "平安推送车辆信息#{formatted_result_succeed}，#{formatted_created_at}。"
     when '/open/appsvr/property/receiveQuotedPrice'
       "华宸报价信息推送#{formatted_result_succeed}，#{formatted_created_at}。"
     when '/InsCarQuo/PingAn/sendHighestBiddingInfo'
       "平安推送中标信息#{formatted_result_succeed}，#{formatted_created_at}。"
     when '/InsCarQuo/PingAn/receiveAuction'
       if  auction.is_entrust == Pingan::EntrustedMessageParser::EntrustingEnum.yes
         "平安推送委托拍卖，#{formatted_created_at}。"
       elsif auction.is_entrust == Pingan::EntrustedMessageParser::EntrustingEnum.no
         "平安推送不拍卖，#{formatted_created_at}。"
       elsif auction.is_entrust == Pingan::EntrustedMessageParser::EntrustingEnum.inquire_again
         "平安推送二次询价，#{formatted_created_at}。"
       end
     when '/open/appsvr/property/receiveQuotedPriceAgain'
       "华宸申请二次报价#{formatted_result_succeed}，#{formatted_created_at}。"
     when '/InsCarQuo/PingAn/multiInquireFeedback'
       "平安二次报价反馈#{formatted_result_succeed}，#{formatted_created_at}。"
     when '/open/appsvr/property/receiveAuctionResult'
       "华宸拍卖信息推送#{formatted_result_succeed}，#{formatted_created_at}。"
     when '/InsCarQuo/PingAn/receiveAuctionCheck'
       "平安拍卖结果复核#{formatted_result_succeed}，#{formatted_created_at}。"
     when '/open/appsvr/property/receiveAuctionTransfer'
       "华宸过户信息推送#{formatted_result_succeed}，#{formatted_created_at}。"
     when '/InsCarQuo/PingAn/receiveTransferInfoCheck'
       "平安过户反馈复核#{formatted_result_succeed}，#{formatted_created_at}。"
     end
  end

  def formatted_created_at
    "推送时间 #{self.created_at}"
  end

  def formatted_result_succeed
    result_succeed? ? '成功' : "失败, #{result_message}"
  end

  def push_in_message?
    self.api_name =~ /\A\/InsCarQuo/
  end
end
