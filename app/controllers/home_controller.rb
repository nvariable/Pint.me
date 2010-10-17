class HomeController < ApplicationController
  before_filter :signed_in?, :only => :dashboard

  def index
  end

  def dashboard
  end

  def search
    internal_provider= Provider.instance
    oauth = Twitter::OAuth.new(internal_provider.configs['twitter']['consumer_key'], internal_provider.configs['twitter']['consumer_secret'])
    oauth.authorize_from_access(current_user.token, current_user.secret)
    client = Twitter::Base.new(oauth)
    @users = client.user_search params[:q] if params[:q].length > 1
    render :layout => false
  end
end
