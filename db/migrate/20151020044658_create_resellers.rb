class CreateResellers < ActiveRecord::Migration
  def change
    create_table :resellers do |t|
      t.string :nama
      t.text :alamat
      t.string :tlp
      t.boolean :status
      t.integer :user_id
      t.belongs_to :r_class, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
