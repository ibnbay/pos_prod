class TriggerPenjualanMaterializeView < ActiveRecord::Migration
  def up
    execute %{
        CREATE OR REPLACE FUNCTION
          refresh_penjualan_lists()
          RETURNS TRIGGER LANGUAGE PLPGSQL
        AS $$
        BEGIN
          REFRESH MATERIALIZED VIEW CONCURRENTLY penjualan_lists;
          RETURN NULL;
        END $$;
      }
    %w(penjualans
         resellers).each do |table|
      execute %{
          CREATE TRIGGER refresh_penjualan_lists
          AFTER
            INSERT OR
            UPDATE OR
            DELETE
          ON #{table}
            FOR EACH STATEMENT
              EXECUTE PROCEDURE
                refresh_penjualan_lists()
        }
    end
  end
  def down
    %w(penjualans
         resellers).each do |table|
      execute %{DROP TRIGGER refresh_penjualan_lists ON #{table}}
    end
    execute %{DROP FUNCTION refresh_penjualan_lists()}
  end
end