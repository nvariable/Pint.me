class HomeController < ApplicationController
  before_filter :signed_in?, :only => :dashboard

  def index
  end

  def dashboard
   fb_user = FbGraph::User.me(current_user.token)
   @fb_friends = fb_user.friends
  end
end
