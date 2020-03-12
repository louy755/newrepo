json.extract! layrec, :id, :name, :phone, :email, :address, :address2, :city, :state, :zip, :sub_total, :tax, :total, :sale_rep, :profit, :margin, :cost, :delivery, :fee, :discount, :tax_inc, :user_id, :created_at, :updated_at
json.url layrec_url(layrec, format: :json)
