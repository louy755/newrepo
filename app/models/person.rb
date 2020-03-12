class Person < ApplicationRecord
  belongs_to :user
  has_many :goods, dependent: :destroy
  has_many :pays, dependent: :destroy
  has_many :delivers, dependent: :destroy
  after_commit :invo_sub
  after_create :capitalize_colmun
  validates :name, presence: true
  validates :phone, presence: true
  validates :email, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true
  private
  def capitalize_colmun
    self.update_columns(financ_com: self.financ_com.capitalize)
  end
  def invo_sub
    invo_sub = 0
    invo_tax = 0
    invo_total = 0
    invo_profit = 0
    invo_margin = 0
    invo_delv = 0
    invo_dis = 0
    invo_fee = 0
    self.goods.each do |itm|
      invo_sub += itm.qny * itm.price
    end
    invo_sub
    begin
      self.update_columns(sub_total: invo_sub)
      invo_tax = invo_sub * 10.25 / 100
      if self.tax_inc
        self.update_columns(tax: invo_tax)
      else
        self.update_columns(tax: 0)
      end
      self.delivers.each do |delv|
        invo_delv += delv.delivery
        invo_dis += delv.discount
        invo_fee += delv.fee
      end
      invo_delv
      self.update_columns(delivery: invo_delv)
      invo_dis
      self.update_columns(discount: invo_dis)
      invo_fee
      self.update_columns(fee: invo_fee)
      invo_total = (invo_sub + invo_tax + invo_delv + invo_fee) - invo_dis
      if self.tax_inc
        self.update_columns(total: invo_total)
      else
        self.update_columns(total: invo_total - invo_tax)
      end
      invo_profit = invo_sub - self.cost
      self.update_columns(profit: invo_profit)
      invo_margin = (invo_profit / invo_sub * 100).round(2)
      self.update_columns(margin: invo_margin)
    rescue => e
      "Rescued: #{e.inspect}"
    end
  end
end
