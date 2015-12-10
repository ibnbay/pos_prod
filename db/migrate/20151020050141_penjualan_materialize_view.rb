class PenjualanMaterializeView < ActiveRecord::Migration
  def up
    execute %{
      CREATE MATERIALIZED VIEW penjualan_lists AS
      SELECT
      a.id         as penjualan_id
      , a.tanggal  as tanggal_penjualan
      , b.nama     as nama_reseller
      , a.total    as total_penjualan
      , a.status  as status_penjualan
      FROM penjualans a, resellers b
      WHERE a.reseller_id = b.id
    }
    execute %{
      CREATE UNIQUE INDEX
      penjualan_lists_penjualan_id
      ON
      penjualan_lists(penjualan_id)
    }
  end
  def down
    execute "DROP MATERIALIZED VIEW penjualan_lists"
  end
end