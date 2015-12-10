class Kategori < ActiveRecord::Base
  has_many :barangs

  validates :nama, presence: true

  accepts_nested_attributes_for :barangs
end
