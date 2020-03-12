class InvoiceLayPdf < Prawn::Document
  include LayrecsHelper
  def initialize(layrec, view_context)
    super(top_margin: 40)
    @layrec = layrec
    @view_context = view_context
    customer_name
    info_tab
  end
  def price(num)
    @view_context.number_to_currency(num)
  end

  def phone_num(num)
    @view_context.number_to_phone(num)
  end

  def customer_name
    text "Customer name: #{@layrec.name.titleize} \n Phone# #{phone_num(@layrec.phone)}", size: 10, style: :bold
  end
  def info_tab
    image "#{Rails.root}/public/pdf/drapplogo.png", :width => 130, :height => 50, :position => :center
    address_info
    customer_info
    main_info
    move_down 5
    text "Payments History", :color => "0000FF", :size => 13, :align => :center
    payments_history
    if @layrec.tax_inc == true
      table [["#{price(lay_sub_totls)} Sub Total"],
             ["#{price(lay_tax_calc)} TAX"],
             ["#{price(lay_inv_delivery)} Delivery if Apply"],
             ["#{price(lay_inv_fee)} Fee if Apply"],
             [{:content => "#{price(lay_inv_dicount)} Discount if Apply ",:colspan => 5,:size => 15, :text_color => "0000ff",:font_style => :bold }],
             [{:content => "#{price(lay_total_reg)} Total Amount ",:colspan => 5,:size => 15, :text_color => "ff3300",:font_style => :bold }],
             [{:content => "#{price(lay_tot_pay)} Total Payments ",:colspan => 5,:size => 13, :text_color => "009900",:font_style => :bold }],
             [{:content => "#{price(lay_tot_reg)} Remaiming due ",:colspan => 5,:size => 15, :text_color => "ff3300",:font_style => :bold }]
            ], :position => :right, :column_widths => [210], :cell_style => {:background_color => "FFFFCC"}
    else
      table [["#{price(lay_sub_totls)} Sub Total"],
             ["#{price(lay_inv_delivery)} Delivery if Apply"],
             ["#{price(lay_inv_fee)} Fee if Apply"],
             [{:content => "#{price(lay_inv_dicount)} Discount if Apply ",:colspan => 5,:size => 15, :text_color => "0000ff",:font_style => :bold }],
             [{:content => "#{price(lay_totall)} Total Amount ",:colspan => 5,:size => 15, :text_color => "ff3300",:font_style => :bold }],
             [{:content => "#{price(lay_tot_pay)} Total Payments ",:colspan => 5,:size => 13, :text_color => "009900",:font_style => :bold }],
             [{:content => "#{price(lay_tot)} Remaiming due ",:colspan => 5,:size => 15, :text_color => "ff3300",:font_style => :bold }]
            ], :position => :right, :column_widths => [210], :cell_style => {:background_color => "FFFFCC"}

    end
    move_down 10
    text "Read over before signing, All deposits are non refundable. 90 days layaway only . ONE PAYMENT EVERY 30 DAY  IS REQUIRED  TO KEEP THE LAYAWAY ACTIVE LAYAWAY WITH NO ACTIVETY FOR 3 MONTHS WILL BE CANCELED .ALL SALES ARE FINAL. All merchandise is sold AS IS INSPECTED By the customer, without warranty, either expressed or implied, except may be offered by the original manufacturer and not the seller. All SALES ARE FINAL and NOT subject to customer cancellation, return. Allowance, charge back, credit adjustments, service or exchange.cus Failure to pick up or accept delivered merchandise may result in20% RESTOCKING FEE OF THE PURCHASE PRICE. Received Merchandise in Good Condition", size: 9
    move_down 20
    text "Customer Signature:  --------------------------------------------------------", size: 10
    move_down 20
    text "Thank You!", size: 11, :align => :center
  end
  def payments_history
    table payments do
      style row(1), :size => 10
      style row(2), :size => 10
      style row(3), :size => 10
      style row(4), :size => 10
      style row(5), :size => 10
      style row(6), :size => 10
      style row(7), :size => 10
      style row(8), :size => 10
      style row(9), :size => 10
      style row(10), :size => 10
      style row(11), :size => 10
      style row(12), :size => 10
      style row(13), :size => 10
      style row(17), :size => 10
      style row(18), :size => 10
      style row(19), :size => 10
      style row(20), :size => 10
      row(0).font_style = :bold
      row(0).style :background_color => 'b3ffb3'
      columns(0..2).width = 110
      columns(3).width = 210
      self.row_colors = [ "FFFFFF", "DDDDDD"]
      self.header = true
    end
  end

  def payments
    [["Amount", "Payment Method", "Rep Name", 'Date']] +
    @layrec.paylays.map do |pay|
      [price(pay.amount),pay.method.titleize, pay.sale_rep.titleize, pay.created_at.strftime("%A, %d %b %Y %l:%M %p")]
    end
  end

  def customer_info
    table line_info_rows do
      style row(1), :size => 10
      cells.style :style_options => {:align => :center}
      row(0).font_style = :bold
      columns(0).width = 110
      columns(1).width = 80
      columns(2).width = 160
      columns(3).width = 70
      columns(4).width = 60
      columns(5).width = 60
      row(0).style :background_color => 'f2e6ff'
      self.row_colors = [ "FFFFFF", "DDDDDD"]
      self.header = true
    end
  end
  def line_info_rows
    [["Name", "Phone", "Adress", "city", "State", "Zip"]] +
    [[@layrec.name.titleize, @layrec.phone,@layrec.address.titleize, @layrec.city.titleize, @layrec.state.titleize, @layrec.zip]]
  end
  def address_info
    text "7601 South Cicero Ave  unit 1486 Chicago il 60652    Phone 773-735-8800 Fax 773-735-8806 \n
    DELIVERY INFORMATION  CALL  773-735-8800", size: 7, style: :bold, :align => :center
  end

  def main_info
    table main do
      row(0).font_style = :bold
      row(0).style :background_color => 'ccf2ff'
      style row(1), :size => 10
      style row(2), :size => 10
      style row(3), :size => 10
      style row(4), :size => 10
      style row(5), :size => 10
      style row(6), :size => 10
      style row(7), :size => 10
      style row(8), :size => 10
      style row(9), :size => 10
      style row(10), :size => 10
      columns(0).width = 50
      columns(1).width = 130
      columns(2).width = 120
      columns(3).width = 90
      columns(4).width = 150
      self.row_colors = [ "FFFFFF", "DDDDDD"]
      self.header = true
    end
  end
  def main
    [["QNT","Item", "Price", "Description", "Date"]] +
    @layrec.goodlays.map do |god|
    [ god.qny,god.item.titleize, price(god.price),  god.discription.upcase, god.created_at.strftime("%A, %d %b %Y")]
    end
  end

end
