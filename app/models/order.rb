class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :purchaser, :class_name => 'User'
  validates_presence_of :user, :purchaser, :quantity 
end
