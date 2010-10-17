class User < ActiveRecord::Base
  has_many :authorizations, :dependent=>:destroy
  validates_uniqueness_of :email, :allow_nil => true
  validates_uniqueness_of :screen_name
  has_many :pints
  has_many :purchased_pints, :class_name => 'Pint', :foreign_key => "purchaser_id"
  has_many :orders, :class_name =>'Order', :foreign_key => 'purchaser_id'
  
  #Compatible with twitter only. Abstraction later for other providers
  def self.create_from_hash!(hash)
    create(
      :name   => hash['user_info']['name'],
      :token  => hash['credentials']['token'],
      :secret => hash['credentials']['secret'],
      :screen_name => hash['extra']['user_hash']['screen_name']
    )
  end

  def update_token(hash)
    self.update_attribute(:token, hash['credentials']['token'])
  end

  def purchase_pint_for(recieving_user)
    reciver = User.find(recieving_user)
    reciver.pints << Pint.new(:purchaser => self)
    reciver.save
  end

  def place_order_for(recieving_user, quantity = 1)
    self.orders.create(:user =>recieving_user, :quantity => quantity)  
  end

  def self.create_from_screen_name(name = nil)
    if sn = self.find_by_screen_name(name)
      return sn
    else
      sn = self.create(
        :screen_name => name
      )
    end
  end
end
