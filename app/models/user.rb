class User < ActiveRecord::Base
  has_many :authorizations, :dependent=>:destroy
  validates_uniqueness_of :email, :screen_name
  has_many :pints
  has_many :purchased_pints, :class_name => 'Pint', :foreign_key => "purchaser_id"
  
  #Compatible with twitter only. Abstraction later for other providers
  def self.create_from_hash!(hash)
    create(
      :name   => hash['user_info']['name'],
      :token  => hash['credentials']['token'],
      :secret => hash['credentials']['secret'],
      :screen_name => hash['extra']['user_hash']['screen_name']
    )
  end

  def update_token(hash)
    self.update_attribute(:token, hash['credentials']['token'])
  end

  def purchase_pint_for(recieving_user)
    reciver = User.find(recieving_user)
    reciver.pints << Pint.new(:purchaser => self)
    reciver.save
  end
end


# {"user_info"=>{
#   "name"=>"tim_linquist", 
#   "location"=>"Spokane Valley, WA", "urls"=>{"Website"=>nil}, "nickname"=>"tim_linquist", "description"=>"Software Engineer, skier, fisherman, son, brother", 
#   "image"=>"http://a2.twimg.com/profile_images/78482510/Vista_eql_Hitler_normal.png"
# }, 
# "uid"=>"17505622", 
# "credentials"=>{
#   "token"=>"17505622-r6AY027xv6f16ZDVt4hsuVwSrCqhK1hrr01VZAAwl", 
#   "secret"=>"pwan51iSNVGkuHraCH611jOycmpFlX62blBnDkMjY"
#   }, 
#   "extra"=>{
#     "user_hash"=>{
#       "profile_background_tile"=>false, "name"=>"tim_linquist", "profile_sidebar_border_color"=>"C0DEED", "profile_sidebar_fill_color"=>"DDEEF6", "location"=>"Spokane Valley, WA", "profile_image_url"=>"http://a2.twimg.com/profile_images/78482510/Vista_eql_Hitler_normal.png", "created_at"=>"Thu Nov 20 05:49:49 +0000 2008", "profile_link_color"=>"0084B4", "follow_request_sent"=>false, "url"=>nil, "contributors_enabled"=>false, "favourites_count"=>0, "utc_offset"=>-28800, "id"=>17505622, "profile_use_background_image"=>true, "listed_count"=>0, "profile_text_color"=>"333333", "protected"=>false, "followers_count"=>35, "lang"=>"en", "profile_background_color"=>"C0DEED", "notifications"=>false, "verified"=>false, "time_zone"=>"Pacific Time (US & Canada)", "geo_enabled"=>false, "description"=>"Software Engineer, skier, fisherman, son, brother", 
#       "statuses_count"=>428, "friends_count"=>15, "profile_background_image_url"=>"http://s.twimg.com/a/1287010001/images/themes/theme1/bg.png", "status"=>{
#         "coordinates"=>nil, "truncated"=>false, "created_at"=>"Wed Jul 28 17:01:53 +0000 2010", "favorited"=>false, "text"=>"http://twitpic.com/29h5uz", "contributors"=>nil, "id"=>19755616393, "retweet_count"=>nil, "geo"=>nil, "retweeted"=>false, 
#         "in_reply_to_user_id"=>nil, "source"=>"Twitter for iPhone", "in_reply_to_screen_name"=>nil, "place"=>nil, "in_reply_to_status_id"=>nil
#         }, 
#       "following"=>false,
#        "show_all_inline_media"=>false, 
#        "screen_name"=>"tim_linquist"
#     }, "access_token"=>#:header, :signature_method=>"HMAC-SHA1", :authorize_path=>"/oauth/authenticate", :site=>"https://api.twitter.com", :request_token_path=>"/oauth/request_token", :proxy=>nil, :http_method=>:post, :access_token_path=>"/oauth/access_token", :oauth_version=>"1.0"}, @http=#, @secret="bV5h1Z4exyDg2kBf0WZAcnH7Llvw5aJABud1brIZxNI", @key="Q7W8g1CtW0OBJ44vVfyBkA", @http_method=:post, @uri=#>, @params={"oauth_token_secret"=>"pwan51iSNVGkuHraCH611jOycmpFlX62blBnDkMjY", :oauth_token=>"17505622-r6AY027xv6f16ZDVt4hsuVwSrCqhK1hrr01VZAAwl", "user_id"=>"17505622", :screen_name=>"tim_linquist", "oauth_token"=>"17505622-r6AY027xv6f16ZDVt4hsuVwSrCqhK1hrr01VZAAwl", :user_id=>"17505622", "screen_name"=>"tim_linquist", :oauth_token_secret=>"pwan51iSNVGkuHraCH611jOycmpFlX62blBnDkMjY"}, @secret="pwan51iSNVGkuHraCH611jOycmpFlX62blBnDkMjY", @response=#>}, 
# "provider"=>"twitter"}