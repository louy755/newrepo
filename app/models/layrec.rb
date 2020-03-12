class Layrec < ApplicationRecord
  belongs_to :user
  has_many :goodlays, dependent: :destroy
  has_many :paylays, dependent: :destroy
  has_many :deliverlays, dependent: :destroy
  after_commit :invo_info
  private
  def invo_info
    invo_sub_lay = 0
    invo_tax_lay  = 0
    invo_total_lay  = 0
    invo_profit_lay  = 0
    invo_margin_lay  = 0
    invo_delv_lay  = 0
    invo_dis_lay  = 0
    invo_fee_lay  = 0
    total_payments = 0
    self.goodlays.each do |itm|
      invo_sub_lay  += itm.qny * itm.price
    end
    self.paylays.each do |pay|
      total_payments += pay.amount
    end
    total_payments
    begin
      self.update_columns(tot_pauments: total_payments )
      invo_sub_lay
      self.update_columns(sub_total: invo_sub_lay )
      invo_tax_lay  = invo_sub_lay * 10.25 / 100
      self.update_columns(tax: invo_tax_lay )
      self.deliverlays.each do |delv|
        invo_delv_lay  += delv.delivery
        invo_dis_lay  += delv.discount
        invo_fee_lay  += delv.fee
      end
      invo_delv_lay
      self.update_columns(delivery: invo_delv_lay )
      invo_dis_lay
      self.update_columns(discount: invo_dis_lay )
      invo_fee_lay
      self.update_columns(fee: invo_fee_lay )
      invo_total_lay  = (invo_sub_lay  + invo_tax_lay  + invo_delv_lay  + invo_fee_lay ) - invo_dis_lay
      self.update_columns(total: invo_total_lay )
      invo_profit_lay  = invo_sub_lay  - self.cost
      self.update_columns(profit: invo_profit_lay )
      invo_margin_lay  = (invo_profit_lay  / invo_sub_lay  * 100).round(2)
      self.update_columns(margin: invo_margin_lay )
    rescue => e
      "Rescued: #{e.inspect}"
    end
  end
end
