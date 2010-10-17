class BusinessesController < ApplicationController
  def index
    @enable_gmap= true
    @businesses = Business.all
  end
end
