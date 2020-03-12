json.extract! exrec, :id, :name, :phone, :email, :tax_inc, :user_id, :created_at, :updated_at
json.url exrec_url(exrec, format: :json)
