class Reseller < ActiveRecord::Base
  belongs_to :r_class
  has_many :penjualans

  validates :nama, :alamat, :tlp, :email, presence: true

  accepts_nested_attributes_for :penjualans
end
