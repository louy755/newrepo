class InvoicePdf < Prawn::Document
  include PeopleHelper
    def initialize(person, view_context)
      super(top_margin: 20)
      @person = person
      @view_context = view_context
      info_tab
    end
    def price(num)
      @view_context.number_to_currency(num)
    end

    def phone_num(num)
      @view_context.number_to_phone(num)
    end

    def invoice_number
      text "Invoice \##{phone_num(@person.phone)}", size: 10
    end
    def customer_name
      text "Customer name: #{@person.name.titleize}", size: 9
    end
    def info_tab
      text_box "#{invoice_number}", :kerning => true, :at => [0, y - 40]
      text_box "#{customer_name}", :kerning => true, :at => [380, y - 40]
      image "#{Rails.root}/public/pdf/drapplogo.png", :width => 130, :height => 50, :position => :center
      address_info
      person_info
      line_items
      # finance and tax sale only
      if @person.tax_inc == true && @person.finance == true
        table [["#{price(sub_totls)} Sub total"],
                ["#{price(tax_calc)} TAX"],
                ["#{price(inv_delivery)} Delivery"],
                ["#{price(inv_fee)} Fee if Apply"],
                [{:content =>"#{price(inv_dicount)} Discount If apply",:text_color => "1a75ff"}],
                [{:content =>"#{price(total_reg)} Total Due",:text_color => "ff3300"}],
                [{:content => "#{price(total_reg)}  #{@person.financ_com.upcase}  ",:colspan => 5,:size => 13, :text_color => "006400" }]
                ], :position => :right, :column_widths => [190], :cell_style => {:background_color => "FFFFCC"}
      # finance sale only!
      elsif @person.finance == true
        table [["#{price(sub_totls)} Sub total"],
                ["#{price(inv_delivery)} Delivery"],
                ["#{price(inv_fee)} Fee if Apply "],
                [{:content =>"#{price(inv_dicount)} Discount If apply",:text_color => "1a75ff"}],
                [{:content =>"#{price(totall)} Total Due",:text_color => "ff3300"}],
                [{:content => "#{price(totall)}  #{@person.financ_com.upcase}  ",:colspan => 5,:size => 13, :text_color => "006400" }]
                ], :position => :right, :column_widths => [190], :cell_style => {:background_color => "FFFFCC"}
      # reguler sale with tax only
      elsif @person.tax_inc == true
        table [["#{price(sub_totls)} Sub total"],
                ["#{price(tax_calc)} TAX"],
                ["#{price(inv_delivery)} Delivery"],
                ["#{price(inv_fee)} Fee if Apply "],
                [{:content =>"#{price(inv_dicount)} Discount If apply",:text_color => "1a75ff"}],
                [{:content =>"#{price(total_reg)} Total Due",:text_color => "ff3300"}],
                [{:content => "#{price(tot_pay)}  Total Payment ",:colspan => 5,:size => 13, :text_color => "006400" }],
                [{:content => "#{price( total_reg - tot_pay)} Remaining ",:colspan => 5,:size => 13, :text_color => "ff3300" }]
                ], :position => :right, :column_widths => [190], :cell_style => {:background_color => "FFFFCC"}
      end
    move_down 10
    text "Read over before signing, All deposits are non refundable. 90 days layaway only . ONE PAYMENT EVERY 30 DAY  IS REQUIRED  TO KEEP THE LAYAWAY ACTIVE LAYAWAY WITH NO ACTIVETY FOR 3 MONTHS WILL BE CANCELED .ALL SALES ARE FINAL. All merchandise is sold AS IS INSPECTED By the customer, without warranty, either expressed or implied, except may be offered by the original manufacturer and not the seller. All SALES ARE FINAL and NOT subject to customer cancellation, return. Allowance, charge back, credit adjustments, service or exchange.cus Failure to pick up or accept delivered merchandise may result in20% RESTOCKING FEE OF THE PURCHASE PRICE. Received Merchandise in Good Condition", size: 9
    move_down 25
    text "Customer Signature:  --------------------------------------------------------", size: 10
    move_down 25
    text "Thank You!", size: 11, :align => :center
    end
    def address_info
      text "7601 South Cicero Ave  unit 1486 Chicago il 60652    Phone 773-735-8800 Fax 773-735-8806 \n
      DELIVERY INFORMATION  CALL  773-735-8800", size: 7, style: :bold, :align => :center
    end

    def person_info
      table line_info_rows do
        style row(1), :size => 10
        cells.style :style_options => {:align => :center}
        row(0).font_style = :bold
        columns(0).width = 90
        columns(1).width = 80
        columns(2).width = 160
        columns(3).width = 80
        row(0).style :background_color => 'f2e6ff'
        self.row_colors = [ "FFFFFF", "DDDDDD"]
        self.header = true
      end
    end
    def line_info_rows
      [["Name", "Phone", "Adress", 'Adress2', "city", "State", "Zip"]] +
      [[@person.name.titleize, @person.phone, @person.address.titleize, @person.address2.titleize, @person.city.titleize, @person.state.titleize, @person.zip]]
    end
    def line_items
      table line_item_rows do
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
        row(0).font_style = :bold
        row(0).style :background_color => 'ccf2ff'
        columns(0).width = 50
        columns(1).width = 100
        columns(2).width = 130
        columns(3).width = 60
        columns(4).width = 60
        columns(5).width = 140
        self.row_colors = [ "FFFFFF", "DDDDDD"]
        self.header = true
      end
    end
    def line_item_rows
      [["QNT", "Item", "Description", "Price", "Subtotal", "Date" ]] +
      @person.goods.map do |itm|
        [itm.qny,itm.item, itm.description, price(itm.price), "#{price(sub_totls)}", itm.created_at.strftime("%A, %d %b %Y") ]
      end
    end
  end
