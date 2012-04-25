
namespace :db do
  desc 'clean gear store specific data and re-run migrations'
  task :clean => :environment do
    connection = ActiveRecord::Base.connection
    tables = ['gs3_rentals', 'gs3_rental_items', 'gs3_deposits', 'gs3_gear_items', 'gs3_gear_item_notes', 'gs3_gear_item_types', 'gs3_ledgers']
    tables.each do |tbl|
      begin
        connection.execute("drop table #{tbl}")
        puts "dropped #{tbl}"
      rescue
      end
    end
    connection.execute("truncate gs3_schema_migrations")
  end
end

