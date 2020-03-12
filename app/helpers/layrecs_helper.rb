module LayrecsHelper

  def lay_sub_totls
    lay_sub_totls = 0
    @layrec.goodlays.each do |comt|
      lay_sub_totls += comt.qny * comt.price
    end
    lay_sub_totls
  end
  def lay_tax_calc
    lay_tax_calc = lay_sub_totls * 10.25 / 100
  end
  def lay_tot_pay
    lay_tot_pay = 0
    @layrec.paylays.each do |pay|
      lay_tot_pay += pay.amount
    end
    lay_tot_pay
  end
  def lay_inv_dicount
    lay_inv_dicount = 0
    @layrec.deliverlays.each do |delv|
      lay_inv_dicount += delv.discount
    end
     lay_inv_dicount ||= "00.00"
  end
  def lay_inv_delivery
    lay_inv_delivery = 0
    @layrec.deliverlays.each do |delv|
      lay_inv_delivery += delv.delivery
    end
    lay_inv_delivery ||= "00.00"
  end
  def lay_inv_fee
      lay_inv_fee = 0
    @layrec.deliverlays.each do |delv|
       lay_inv_fee = delv.fee
    end
    lay_inv_fee
  end
  def lay_totall
    lay_totll = lay_sub_totls + lay_inv_fee + lay_inv_delivery - lay_inv_dicount
  end
  def lay_total_reg
    lay_total_reg = lay_tax_calc + lay_sub_totls + lay_inv_fee + lay_inv_delivery - lay_inv_dicount
  end
  def lay_tot_reg
    lay_tot_trg = 0
    lay_tot_trg = (lay_total_reg - lay_tot_pay).round(2)
  end
  def lay_tot
    lay_tot = 0
    lay_tot = (lay_totall  - lay_tot_pay).round(2)
  end
  def lay_total_invoices
    totals = 0
    Layrec.all.each do |per|
     totals += per.total
    end
    totals
  end
  def lay_total_subs
    total_subs = 0
    Layrec.all.each do |per|
     total_subs += per.sub_total
    end
    total_subs
  end
  def lay_total_taxs
    total_taxs = 0
    Layrec.all.each do |per|
     total_taxs += per.tax
    end
    total_taxs
  end
  def lay_total_fees
    total_fees = 0
    Layrec.all.each do |per|
     total_fees += per.fee
    end
    total_fees
  end
  def lay_total_discounts
    total_discounts = 0
    Layrec.all.each do |per|
     total_discounts += per.discount
    end
    total_discounts
  end
  def lay_total_costs
    total_costs = 0
    Layrec.all.each do |per|
     total_costs += per.cost
    end
    total_costs
  end
  def lay_total_delvs
    total_delvs = 0
    Layrec.all.each do |per|
     total_delvs += per.delivery
    end
    total_delvs
  end
  def lay_total_profits
    total_profits = 0
    Layrec.all.each do |per|
     total_profits += per.profit
    end
    total_profits
  end
end
