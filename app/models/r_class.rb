class RClass < ActiveRecord::Base
  has_many :resellers
  has_many :h_barangs

  validates :nama, presence: true

  accepts_nested_attributes_for :h_barangs
  accepts_nested_attributes_for :resellers
end
