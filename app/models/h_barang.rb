class HBarang < ActiveRecord::Base
  before_create :check_harga
  before_update :check_harga

  belongs_to :barang
  belongs_to :r_class

  def check_harga
    if self.satuan == nil
      then self.satuan = 0
    end
  end
end
