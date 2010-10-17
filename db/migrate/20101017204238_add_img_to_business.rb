class AddImgToBusiness < ActiveRecord::Migration
  def self.up
    add_column :businesses, :company_logo, :string
  end

  def self.down
    remove_column :businesses, :company_logo
  end
end
