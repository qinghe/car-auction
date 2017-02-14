## MaintainAuctions 计划任务 每10分钟 維護 auctions
class MaintainAuctions
  attr_accessor :time

  def initialize( some_time = nil)
    self.time = some_time || DateTime.current
  end

  def run
    Auction.active.each{|auction|
         if auction.closed?
          auction.close!
        end
 
    }
  end
end
