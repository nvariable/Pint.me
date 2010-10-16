class Business < ActiveRecord::Base
  has_many :pints

  validates_numericality_of :secret_code
  validates_format_of :secret_code, :with => /\d\d\d\d/

  validates_presence_of :name
  validates_presence_of :street_1
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zip
end
