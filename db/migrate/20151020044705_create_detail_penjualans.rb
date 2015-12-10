class CreateDetailPenjualans < ActiveRecord::Migration
  def change
    create_table :detail_penjualans do |t|
      t.integer :jumlah
      t.decimal :amount
      t.belongs_to :penjualan, index: true, foreign_key: true
      t.belongs_to :barang, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
