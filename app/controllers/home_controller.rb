class HomeController < ApplicationController
  before_filter :require_login, :except => [:index]

  def index
    if current_user
      redirect_to home_dashboard_path
    end
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

  def widgets
  end
end
