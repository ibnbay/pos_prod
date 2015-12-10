class CreateRClasses < ActiveRecord::Migration
  def change
    create_table :r_classes do |t|
      t.string :nama
      t.boolean :status

      t.timestamps null: false
    end
  end
end
