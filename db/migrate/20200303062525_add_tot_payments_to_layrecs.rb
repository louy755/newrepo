class AddTotPaymentsToLayrecs < ActiveRecord::Migration[6.0]
  def change
    add_column :layrecs, :tot_pauments, :decimal, default: "0.0"
  end
end
