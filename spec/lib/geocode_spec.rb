require File.dirname(__FILE__) + '/../spec_helper'

describe Geocode do
  before(:each) do
    @address= Factory.build(:address)
    @geocode = Geocode.new(@address.to_s)
    @geocoder = @geocode.geocoder
    @geocode.stub!(:geocoder).and_return(@geocoder)
    @location= mock('Graticule Location', :coordinates=>[44.0589124, -121.2999967])
    @geocoder.stub!(:locate).and_return(@location)
  end
  
  it "should find the coordinates for the address" do
    @geocoder.should_receive(:locate).with(@address.to_s)
    @geocode.coordinates.should eql(@location.coordinates)
  end

  it "should get the latitude" do
    @geocode.latitude.should eql(@location.coordinates.first)    
  end
  
  it "should get the longitude" do
    @geocode.longitude.should eql(@location.coordinates.last)        
  end
end
