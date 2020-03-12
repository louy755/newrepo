class CreateExrecs < ActiveRecord::Migration[6.0]
  def change
    create_table :exrecs do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.boolean :tax_inc, default: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
