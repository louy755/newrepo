class CreateGoodlays < ActiveRecord::Migration[6.0]
  def change
    create_table :goodlays do |t|
      t.integer :qny, default: "0"
      t.string :item
      t.decimal :price, default: "0.0"
      t.string :discription
      t.string :vendor
      t.decimal :subtotal, default: "0.0"
      t.references :layrec, null: false, foreign_key: true

      t.timestamps
    end
  end
end
