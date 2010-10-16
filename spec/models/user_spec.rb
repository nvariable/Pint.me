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
      "credentials"=>{"token"=>"158316420866575|445b1afa8d4e1451a94036eb-100000108317889|BFgUXWQS8Qjzvet7nk4eeoZDImI"}, 
      "extra"=>{
        "user_hash"=>{
          "name"=>"Tim Linquist", 
          "gender"=>"male", 
          "id"=>"100000108317889", 
          "email"=>"tim.linquist@gmail.com"
    }}}
  end

  it "should create a user with the name, uid, token, and email" do
    user= User.create_from_hash!(@response)
    user.new_record?.should be_false
    [:name, :email, :token].each{|a| user.send(a).should_not be_nil}
  end

  context "associations" do
    it {should have_many :pints }
  end
end
