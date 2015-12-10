class UpdateDetailPenjualan < ActiveRecord::Migration
  def up
    execute %{
          CREATE OR REPLACE FUNCTION
          update_detail_barang()
          RETURNS TRIGGER LANGUAGE PLPGSQL
          AS $$
          BEGIN
            UPDATE Detail_Penjualans
            SET amount =
            (SELECT (b.jumlah * d.satuan)
            FROM Penjualans a, Detail_Penjualans b, Resellers c,
              (SELECT a.id, b.satuan, b.r_class_id
               FROM Barangs a, H_Barangs b
               WHERE a.id = b.barang_id
              ) d
            WHERE b.id = NEW.id
            AND a.id = b.penjualan_id
            AND a.reseller_id = c.id
            AND b.barang_id = d.id
            AND c.r_class_id = d.r_class_id
            )
            WHERE id = NEW.id
            AND penjualan_id = NEW.penjualan_id;

            RETURN NULL;
            END $$;
        }
      execute %{
            CREATE TRIGGER update_detail_barang
            AFTER INSERT ON Detail_Penjualans
            FOR EACH ROW EXECUTE PROCEDURE update_detail_barang()
          }
  end
  def down
    execute %{DROP TRIGGER update_detail_barang ON Detail_Penjualans}
    execute %{DROP FUNCTION update_detail_barang()}
  end
end
