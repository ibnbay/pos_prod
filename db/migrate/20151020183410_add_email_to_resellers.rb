class AddEmailToResellers < ActiveRecord::Migration
  def change
    add_column :resellers, :email, :string
  end
end
