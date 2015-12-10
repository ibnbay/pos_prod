class CreateBarangs < ActiveRecord::Migration
  def change
    create_table :barangs do |t|
      t.string :nama
      t.integer :stock
      t.decimal :satuan
      t.boolean :status
      t.belongs_to :kategori, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
