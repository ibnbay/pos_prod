class CreateHBarangs < ActiveRecord::Migration
  def change
    create_table :h_barangs do |t|
      t.decimal :satuan
      t.belongs_to :barang, index: true, foreign_key: true
      t.belongs_to :r_class, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
