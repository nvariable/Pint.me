class PayPalToken < ActiveRecord::Migration
  def self.up
    add_column :orders, :paypal_token, :string
    add_index :orders, :paypal_token
  end

  def self.down
    remove_column :orders, :paypal_token
  end
end
