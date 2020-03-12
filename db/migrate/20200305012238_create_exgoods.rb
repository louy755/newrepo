class CreateExgoods < ActiveRecord::Migration[6.0]
  def change
    create_table :exgoods do |t|
      t.integer :qny, default: "0.0"
      t.string :item
      t.string :description
      t.decimal :price, default: "0.0"
      t.decimal :subtotal, default: "0.0"
      t.references :exrec, null: false, foreign_key: true

      t.timestamps
    end
  end
end
