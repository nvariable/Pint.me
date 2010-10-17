class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.integer :purchaser_id
      t.integer :user_id
      t.integer :quantity
      t.string :ip_address
      t.string :transaction_id
      t.datetime :date_paid
      t.timestamps
    end
    add_column :pints, :order_id, :integer
  end

  def self.down
    drop_table :orders
    remove_column :pints, :order_id
  end
end
