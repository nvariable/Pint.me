class Business < ActiveRecord::Base
  has_many :pints

  validates_numericality_of :secret_code, :allow_nil=>true
  validates_format_of :secret_code, :with => /\d\d\d\d/, :allow_nil=>true

  validates_presence_of :name
  validates_presence_of :street_1
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zip
    
  def to_s
    "#{street_1}, #{city}, #{state}"
  end  
  
  def latitude
    geocode.latitude
  end
  
  def longitude
    geocode.longitude
  end
  
  def geocode
    @geocode ||= Geocode.new(self.to_s)
  end
end
