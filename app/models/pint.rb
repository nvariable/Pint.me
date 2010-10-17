class Pint < ActiveRecord::Base
  belongs_to :user, :counter_cache => true
  belongs_to :order
  belongs_to :business
  belongs_to :purchaser, :class_name => 'User', :counter_cache => true

  scope :available, where(:business_id => nil)
end
