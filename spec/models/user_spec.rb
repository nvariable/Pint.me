require 'spec_helper'

describe User do
  before(:each) do
    @response= {
      "user_info"=>{
        "name"=>"Tim Linquist", 
        "nickname"=>"profile.php?id=100000108317889", 
        "last_name"=>"Linquist", 
        "first_name"=>"Tim"
      }, 
      "uid"=>"100000108317889", 
      "credentials"=>{
        "token"=>"158316420866575|445b1afa8d4e1451a94036eb",
        "secret"=>"100000108317889|BFgUXWQS8Qjzvet7nk4eeoZDImI"
        }, 
      "extra"=>{
        "user_hash"=>{
          "name"=>"Tim Linquist", 
          "gender"=>"male", 
          "screen_name"=>'tim_linquist'
    }}}
  end

  it "should create authorization from hash even with placeholder user in place" do
    @user = User.create_from_screen_name('tim_linquist')
    @auth = User.create_from_hash!(@response)
    @auth.id.should == @user.id
  end

  it "should create a placeholder user with a new screen name" do
    lambda{
      User.create_from_screen_name('wycats')
    }.should change(User, :count).by(1)
  end

  it "should return an existing user if screen name already exists" do
    user_1 = User.create_from_screen_name('joey')
    User.create_from_screen_name('joey').should == user_1
  end

  it "should create a user with the name, uid, and token" do
    user= User.create_from_hash!(@response)
    user.new_record?.should be_false
    [:name, :token, :secret, :screen_name].each{|a| user.send(a).should_not be_nil}
  end

  it "should update the token" do
    user= Factory(:user, :token=>nil)
    user.update_token(@response)
    user.reload
    user.token.should_not be_nil
  end
  
  context "associations" do
    it {should have_many :pints }
    it {should have_many :purchased_pints }
    it {should have_many :orders}
  end

  context "purchasing pints" do
    before(:each) do
      @user = Factory(:user)
      @user2 = Factory(:user)
    end 

    it "should mark a pint as purchased by a user" do
      @user.purchase_pint_for(@user2)
      @user.purchased_pints.count.should == 1
      @user2.pints.first.purchaser.should == @user
    end
  end

  context "receiving pints" do
    before(:each) do
      @current_user = Factory(:user)
      @purchaser = Factory(:user)
    end

    it "should increase their pints count" do
      @purchaser.purchase_pint_for(@current_user)
      @current_user.pints.count.should == 1
      @current_user.pints.first.purchaser.should == @purchaser
    end
  end

  context "order pints" do
    before(:each) do
      @user = Factory(:user)
      @user2 = Factory(:user)
    end
    it "should add an order for pints" do
      lambda{
        @user.place_order_for(@user2)
      }.should change(@user.orders, :count).by(1)
    end
  end
end
