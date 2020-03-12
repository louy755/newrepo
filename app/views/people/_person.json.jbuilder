json.extract! person, :id, :name, :phone, :email, :address, :address2, :city, :state, :zip, :sub_total, :tax, :total, :slae_rep, :profit, :margin, :cost, :delivery, :fee, :discount, :finance, :tax_inc, :user_id, :created_at, :updated_at
json.url person_url(person, format: :json)
