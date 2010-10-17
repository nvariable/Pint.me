class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :purchaser, :class_name => 'User'
  validates_presence_of :user, :purchaser, :quantity, :number
  validates_uniqueness_of :number

  def self.generate_order_number
    record = true
    while record
      random = "S#{Array.new(9){rand(9)}.join}"
      record = Order.find(:first, :conditions => ["number = ?", random])
    end
    return random  
  end
end
