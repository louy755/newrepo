module DeliversHelper
  def delivery_fee
    delivery_fee = 0
    @delivers.each do |delv|
      delivery_fee += delv.delivery
    end
    delivery_fee
  end
end
