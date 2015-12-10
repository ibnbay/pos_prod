class TriggerBarangMaterializeView < ActiveRecord::Migration
  def up
    execute %{
          CREATE OR REPLACE FUNCTION
            refresh_barang_kategoris()
            RETURNS TRIGGER LANGUAGE PLPGSQL
          AS $$
          BEGIN
            REFRESH MATERIALIZED VIEW CONCURRENTLY barang_kategoris;
            RETURN NULL;
          END $$;
        }
    %w(kategoris
           barangs).each do |table|
      execute %{
            CREATE TRIGGER refresh_barang_kategoris
            AFTER
              INSERT OR
              UPDATE OR
              DELETE
            ON #{table}
              FOR EACH STATEMENT
                EXECUTE PROCEDURE
                  refresh_barang_kategoris()
          }
    end
  end
  def down
    %w(kategoris
           barangs).each do |table|
      execute %{DROP TRIGGER refresh_barang_kategoris ON #{table}}
    end
    execute %{DROP FUNCTION refresh_barang_kategoris()}
  end
end