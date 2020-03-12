class AssDeliveryDateToPeople < ActiveRecord::Migration[6.0]
  def change
    add_column :people, :delivery_date, :date
  end
end
