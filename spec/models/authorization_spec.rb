require 'spec_helper'

describe Authorization do
  describe "Valid" do
    before(:each) do
      @auth= Factory.build(:authorization)
    end
    
    [:user_id, :uid, :provider].each do |_attr|
      it "should validate the presence of #{_attr}" do
        @auth.send("#{_attr}=", nil)
        @auth.should_not be_valid
      end
    end
    
    it "should not allow two authorizations to share the same uid/provider" do
      @auth.save
      @auth_2= Factory.build(:authorization, :uid=>@auth.uid, :provider=>@auth.provider)
      @auth_2.save.should be_false
      @auth_2.errors[:uid].should_not be_nil
    end
  end
end
