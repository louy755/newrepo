class AddSaleRepToPaylays < ActiveRecord::Migration[6.0]
  def change
    add_column :paylays, :sale_rep, :string
  end
end
