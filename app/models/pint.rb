class Pint < ActiveRecord::Base
  belongs_to :user, :counter_cache => true
  belongs_to :business
  belongs_to :purchaser, :class_name => 'User', :counter_cache => true
end
