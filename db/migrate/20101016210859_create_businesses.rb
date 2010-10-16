class CreateBusinesses < ActiveRecord::Migration
  def self.up
    create_table :businesses do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :businesses
  end
end
