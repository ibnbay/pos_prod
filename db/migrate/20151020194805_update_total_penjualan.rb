class UpdateTotalPenjualan < ActiveRecord::Migration
  def up
    execute %{
          CREATE OR REPLACE FUNCTION
          update_total_penjualan()
          RETURNS TRIGGER LANGUAGE PLPGSQL
          AS $$
          BEGIN
            UPDATE Penjualans
            SET total =
            (SELECT sum(amount)
            FROM Detail_Penjualans
            WHERE penjualan_id = OLD.penjualan_id
            )
                  WHERE id = OLD.penjualan_id;

            RETURN NULL;
            END $$;
        }
    execute %{
            CREATE TRIGGER update_total_penjualan
            AFTER UPDATE ON Detail_Penjualans
            FOR EACH ROW EXECUTE PROCEDURE update_total_penjualan()
          }
  end
  def down
    execute %{DROP TRIGGER update_total_penjualan ON Detail_Penjualans}
    execute %{DROP FUNCTION update_total_penjualan()}
  end
end
