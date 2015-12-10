class Penjualan < ActiveRecord::Base
  before_create :set_date

  belongs_to :reseller

  has_many :detail_penjualans

  accepts_nested_attributes_for :detail_penjualans

  def set_date
    self.tanggal = Date.today
  end
end
