class PintCounters < ActiveRecord::Migration
  def self.up
    add_column :users, :purchased_count, :integer, :default => 0
    add_column :users, :pints_count, :integer, :default =>0
  end

  def self.down
    remove_column :users, :purchased_count
    remove_column :users, :pints_count
  end
end
