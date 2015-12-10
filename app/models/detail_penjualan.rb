class DetailPenjualan < ActiveRecord::Base
  belongs_to :penjualan
  belongs_to :barang
end
