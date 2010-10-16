class CreatePints < ActiveRecord::Migration
  def self.up
    create_table :pints do |t|
      t.column  :user_id, :integer
      t.column  :business_id, :integer
      t.column  :redemption_date, :datetime
      t.column  :purchaser_id, :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :pints
  end
end
