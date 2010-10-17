class HomeController < ApplicationController
  before_filter :signed_in?, :only => :dashboard

  def index
  end

  def dashboard
  end
end
