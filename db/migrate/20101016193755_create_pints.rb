class CreatePints < ActiveRecord::Migration
  def self.up
    create_table :pints do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :pints
  end
end
