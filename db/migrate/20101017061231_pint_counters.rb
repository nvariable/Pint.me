class PintCounters < ActiveRecord::Migration
  def self.up
    add_column :users, :pints_purchased, :integer
    add_column :users, :pints_received, :integer
  end

  def self.down
    remove_column :users, :pints_purchased
    remove_column :users, :pints_received
  end
end
