require 'spec_helper'

describe Business do
  subject{ Factory.build(:business) }
  context 'associations' do
    it { should have_many :pints }
  end

  it "should include the street_1, city, state (comma delimited)" do
    attrs= [subject.street_1, subject.city , subject.state].join(", ")
    subject.to_s.should =~ %r{#{attrs}}
  end

  describe "Geocoding" do
    before(:each) do
      lat, long = 44.0589124, -121.2999967
      @business, @geocode =Factory.build(:business), mock(Geocode, :latitude=>lat, :longitude=>long, :coordinates=>[lat,long])
      @business.stub!(:geocode).and_return(@geocode)
    end
    
    it "should know its latitude" do
      @business.latitude.should be_an_instance_of(Float)
    end
    
    it "should know its longitude" do
      @business.longitude.should be_an_instance_of(Float)      
    end
  end

  context 'validations' do
    it 'should verify that the secret code is a digit' do
      should validate_numericality_of(:secret_code)
    end

    it 'should verify that the secret code is 4 digits' do
      should validate_format_of(:secret_code).with(12340).with_message(/secret_code is invalid/)
    end

    it { should validate_presence_of :name }
    it { should validate_presence_of :street_1 }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
  end
end
