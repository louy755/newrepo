class SamplePdf < Prawn::Document
  include ExrecsHelper
    def initialize(exrec, view_context)
      super(top_margin: 20)
      @exrec = exrec
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
      text "Invoice \##{phone_num(@exrec.phone)}", size: 10
    end
    def customer_name
      text "Customer name: #{@exrec.name.titleize}", size: 9
    end
    def info_tab
      text_box "#{invoice_number}", :kerning => true, :at => [0, y - 40]
      text_box "#{customer_name}", :kerning => true, :at => [380, y - 40]
      image "#{Rails.root}/public/pdf/drapplogo.png", :width => 130, :height => 50, :position => :center
      address_info
      person_info
      customer_info
      line_items
      create_stamp("approved") do
        rotate(30, :origin => [-15, -15]) do
          stroke_color "FF3333"
          stroke_ellipse [0, 0], 35, 20
          stroke_color "000000"
          fill_color "993333"
          font("Times-Roman") do
            draw_text "Sample Inv", :at => [-23, -3]
          end
          fill_color "000000"
        end
      end

      stamp_at "approved", [250, 630]

      if @exrec.tax_inc
        table [["#{price(exsub_totls)} Sub total"],
                ["#{price(extax_calc)} TAX"],
                ["#{price(exinv_delivery)} Delivery"],
                ["#{price(exinv_fee)} Fee if Apply"],
                ["#{price(exinv_dicount)} Discount If applys"],
                [{:content =>"#{price(extotall_tax)} Estmate Cost",:text_color => "ff3300"}],
                ], :position => :right, :column_widths => [200], :cell_style => {:background_color => "FFFFCC"}
      else
        table [["#{price(exsub_totls)} Sub total"],
               ["#{price(exinv_delivery)} Delivery"],
               ["#{price(exinv_fee)} Fee if Apply"],
               [{:content =>"#{price(exinv_dicount)} Discoint if Apply",:size => 13, :text_color => "0000ff"}],
               [{:content =>"#{price(extotall)} Estmate Cost",:text_color => "ff3300"}],
              ], :position => :right, :column_widths => [200], :cell_style => {:background_color => "FFFFCC"}
      end
    move_down 30
    image "#{Rails.root}/public/pdf/sampleinvoice.png", :width => 500, :height => 30, :position => :center
    move_down 25
    text "Thank You!", size: 11, :align => :center
    end
    def address_info
      text "7601 South Cicero Ave  unit 1486 Chicago il 60652    Phone 773-735-8800 Fax 773-735-8806 \n
      DELIVERY INFORMATION  CALL  773-735-8800", size: 7, style: :bold, :align => :center
    end
    def person_info
      table customer_info do
        style row(1), :size => 10
        cells.style :style_options => {:align => :center}
        row(0).font_style = :bold
        columns(0).width = 140
        columns(1).width = 200
        columns(2).width = 200
        row(0).style :background_color => 'f2e6ff'
        self.row_colors = [ "FFFFFF", "DDDDDD"]
        self.header = true
      end
    end
    def customer_info
      [["Name", "Phone", 'Date']] +
      [[@exrec.name.titleize, @exrec.phone, @exrec.created_at.strftime("%A, %d %b %Y")]]
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
        columns(0).width = 70
        columns(1).width = 170
        columns(2).width = 100
        columns(3).width = 200

        self.row_colors = [ "FFFFFF", "DDDDDD"]
        self.header = true
      end
    end
    def line_item_rows
      [["QNT", "Item", "Description", "Price" ]] +
      @exrec.exgoods.map do |itm|
        [itm.qny,itm.item, itm.description, price(itm.price) ]
      end
    end
  end
