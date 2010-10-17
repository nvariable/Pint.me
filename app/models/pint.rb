class Pint < ActiveRecord::Base
  belongs_to :user
  belongs_to :business
  belongs_to :purchaser, :class_name => 'User'
end
