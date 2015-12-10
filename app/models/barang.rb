class Barang < ActiveRecord::Base
  belongs_to :kategori

  has_many :h_barangs

  accepts_nested_attributes_for :h_barangs

  validates :nama, presence: true

end
