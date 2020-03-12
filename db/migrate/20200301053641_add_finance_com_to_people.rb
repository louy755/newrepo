class AddFinanceComToPeople < ActiveRecord::Migration[6.0]
  def change
    add_column :people, :financ_com, :string
  end
end
