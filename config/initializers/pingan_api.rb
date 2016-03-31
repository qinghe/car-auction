# output message
#===============================================================================
# 2
Pingan::QuotedPriceMessage.api_path = '/open/appsvr/property/receiveQuotedPrice'

# 5
Pingan::QuotedPriceAgainMessage.api_path = '/open/appsvr/property/receiveQuotedPriceAgain'

# 7
Pingan::AuctionResultMessage.api_path = '/open/appsvr/property/receiveAuctionResult'

# 9
Pingan::TransferInfoMessage.api_path = '/open/appsvr/property/receiveAuctionTransfer'


# income message handler
#===============================================================================
# 1
Pingan::CarInquireInfoParser.api_path = '/InsCarQuo/PingAn/sendCarInquireInfo'

# 3
Pingan::BiddingInfoParser.api_path = '/InsCarQuo/PingAn/sendHighestBiddingInfo'

# 4
Pingan::EntrustedMessageParser.api_path = '/InsCarQuo/PingAn/receiveAuction'

# 6
Pingan::MultiInquireFeedbackHandler.api_path = '/InsCarQuo/PingAn/multiInquireFeedback'

# 8
Pingan::AuctionResultCheckHandler.api_path = '/InsCarQuo/PingAn/receiveAuctionCheck'

# 10
Pingan::TransferInfoCheckParser.api_path = '/InsCarQuo/PingAn/receiveTransferInfoCheck'
