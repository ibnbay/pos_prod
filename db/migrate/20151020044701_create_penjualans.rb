class CreatePenjualans < ActiveRecord::Migration
  def change
    create_table :penjualans do |t|
      t.date :tanggal
      t.decimal :total
      t.integer :status
      t.belongs_to :reseller, index: true, foreign_key: true
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
