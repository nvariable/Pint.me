class Geocode
  def initialize(address)
    @address= address
  end
  
  def latitude
    coordinates.first
  end
  
  def longitude
    coordinates.last
  end
  
  def coordinates
    @coordinates ||= geocoder.locate(@address).coordinates
  end
  
  def geocoder
    @geocoder ||= Graticule.service(:google).new('') #no key needed for Google Geocoding/Maps v3
  end  
end