require 'spec_helper'

describe Authorization do
  describe "Valid" do
    before(:each) do
      @auth= Factory(:authorization)
    end
    
    after(:each) do
      @auth.destroy
    end
    
    [:user_id, :uid, :provider].each do |_attr|
      it "should validate the presence of #{_attr}" do
        @auth.send("#{_attr}=", nil)
        @auth.should_not be_valid
      end
    end
    
    it "should not allow two authorizations to share the same uid/provider" do
      @auth_2= Factory.build(:authorization, :uid=>@auth.uid, :provider=>@auth.provider)
      @auth_2.save.should be_false
      @auth_2.errors[:uid].should_not be_nil
    end
    
    describe "Omniauth" do
      describe "Finding from omniauth response" do
        before(:each) do
          @response= {'provider'=>@auth.provider, 'uid'=>@auth.uid}
        end
        it "should find the authorization" do
          Authorization.find_from_hash(@response).should eql(@auth)
        end

        it "should not find the authorization" do
          Authorization.find_from_hash({'provider'=>'twitter', 'uid'=>'18duawe128d'}).should be_nil        
        end
      end

      describe "Creating an authorization from the omniauth response" do
        before(:each) do
          @response= {'provider'=>'twitter', 'uid'=>'19129adadj1'}
          @user= Factory(:user)
          User.stub!(:create_from_hash!).and_return(@user)
        end
        
        after(:each) do
          @user.authorizations.destroy_all
        end
        
        it "should create a user if the user isn't specified" do
          User.should_receive(:create_from_hash!).with(@response).and_return(@user)
          Authorization.create_from_hash!(@response)
        end

        it "should create the authorization with the user, uid, and provider" do
          Authorization.create_from_hash!(@response)    
          Authorization.find_by_user_id_and_uid_and_provider(@user.id, @response['uid'], @response['provider']).should_not be_nil      
        end
      end
    end
  end
end
