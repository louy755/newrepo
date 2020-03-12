class CreateExdlvs < ActiveRecord::Migration[6.0]
  def change
    create_table :exdlvs do |t|
      t.decimal :delivery, default: "0.0"
      t.decimal :fee, default: "0.0"
      t.decimal :discount, default: "0.0"
      t.references :exrec, null: false, foreign_key: true

      t.timestamps
    end
  end
end
