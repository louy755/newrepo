class CreateGoods < ActiveRecord::Migration[6.0]
  def change
    create_table :goods do |t|
      t.integer :qny, default: "0.0"
      t.string :item
      t.decimal :price, default: "0.0"
      t.string :description
      t.string :vendor
      t.decimal :subtotal, default: "0.0"
      t.references :person, null: false, foreign_key: true

      t.timestamps
    end
  end
end
