class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :purchaser, :class_name => 'User'
  validates_presence_of :user, :purchaser, :quantity, :number
  validates_uniqueness_of :number
  PINT_PRICE = 500 #in pennies for active_merchant

  def total
    self.quantity * Order.pint_price
  end

  def send_pints
    return true if !self.date_paid.nil?
    self.quantity.times do |i|
      self.purchaser.purchase_pint_for(self.user, self.id)
    end
    self.update_attribute('date_paid', Time.now)
  end

  def self.generate_order_number
    record = true
    while record
      random = "S#{Array.new(9){rand(9)}.join}"
      record = Order.find(:first, :conditions => ["number = ?", random])
    end
    return random  
  end

  def self.pint_price
    PINT_PRICE
  end
end
