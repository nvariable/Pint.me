require 'forwardable'

class Business < ActiveRecord::Base
  extend Forwardable
  def_delegators :@geocode, :latitude, :longitude
  
  has_many :pints

  validates_numericality_of :secret_code
  validates_format_of :secret_code, :with => /\d\d\d\d/

  validates_presence_of :name
  validates_presence_of :street_1
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zip
  
  def to_s
    "#{street_1}, #{city}, #{state}"
  end  
  
  def geocode
    @geocode ||= Geocode.new(self.to_s)
  end
end
