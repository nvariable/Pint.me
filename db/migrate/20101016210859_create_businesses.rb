class CreateBusinesses < ActiveRecord::Migration
  def self.up
    create_table :businesses do |t|
      t.column :name, :string
      t.column :street_1, :string
      t.column :street_2, :string
      t.column :city, :string
      t.column :state, :string
      t.column :zip, :string
      t.column :report_email, :string
      t.column :secret_code, :integer
      
      t.timestamps
    end
  end

  def self.down
    drop_table :businesses
  end
end
