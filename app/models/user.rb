class User < ActiveRecord::Base
  has_many :authorizations
  validates_uniqueness_of :email
  has_many :pints
  
  #Compatible with facebook only. Abstraction later for other providers
  def self.create_from_hash!(hash)
    create(
      :name   => hash['user_info']['name'],
      :token  => hash['credentials']['token'],
      :email  => hash['extra']['user_hash']['email']
    )
  end
end
