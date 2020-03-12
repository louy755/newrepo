module ExrecsHelper
  def exsub_totls
    exsub_totls = 0
    @exrec.exgoods.each do |comt|
      exsub_totls += comt.qny * comt.price
    end
    exsub_totls
  end
  def extax_calc
    extax_calc = exsub_totls * 10.25 / 100
  end
  def exinv_dicount
    exinv_dicount = 0
    @exrec.exdlvs.each do |delv|
      exinv_dicount += delv.discount
    end
     exinv_dicount ||= "00.00"
  end
  def exinv_delivery
    exinv_delivery = 0
    @exrec.exdlvs.each do |delv|
      exinv_delivery += delv.delivery
    end
    exinv_delivery ||= "00.00"
  end
  def exinv_fee
      exinv_fee = 0
    @exrec.exdlvs.each do |delv|
       exinv_fee = delv.fee
    end
    exinv_fee
  end
  def extotall
    extotll = (exsub_totls + exinv_fee + exinv_delivery) - exinv_dicount
  end
  def extotall_tax
    extotll = (exsub_totls + exinv_fee + exinv_delivery + extax_calc) - exinv_dicount
  end
end
