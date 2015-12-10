class BarangMaterializeView < ActiveRecord::Migration
  def up
    execute %{
      CREATE MATERIALIZED VIEW barang_kategoris AS
      SELECT
      a.id        as barang_id
      , a.nama    as nama_barang
      , a.status  as status_barang
      , b.nama    as nama_kategori
      FROM barangs a, kategoris b
      WHERE a.kategori_id = b.id
    }
    execute %{
      CREATE UNIQUE INDEX
      barang_kategoris_barang_id
      ON
      barang_kategoris(barang_id)
    }
  end
  def down
    execute "DROP MATERIALIZED VIEW barang_kategoris"
  end
end