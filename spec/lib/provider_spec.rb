require File.dirname(__FILE__) + '/../spec_helper'

describe Provider do
  before(:each) do
    @provider= Provider.instance
  end
  
  it "should know the configuration" do
    @provider.configs.should be_an_instance_of(Hash)
  end
  
  it "should have facebook as a provider" do
    @provider.configs['facebook'].should be_an_instance_of(Hash)
  end
  
  it "should have twitter as a provider" do
    @provider.configs['twitter'].should be_an_instance_of(Hash)
  end
end
