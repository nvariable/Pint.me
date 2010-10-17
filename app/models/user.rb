class User < ActiveRecord::Base
  has_many :authorizations
  validates_uniqueness_of :email
  has_many :pints
  has_many :purchased_pints, :class_name => 'Pint', :foreign_key => "purchaser_id"
  
  #Compatible with facebook only. Abstraction later for other providers
  def self.create_from_hash!(hash)
    create(
      :name   => hash['user_info']['name'],
      :token  => hash['credentials']['token'],
      :email  => hash['extra']['user_hash']['email']
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
end
