class PintsController < ApplicationController
  before_filter :require_login
  def index
    @pints = Pint.all
  end

  def buy
    @recipient = User.create_from_screen_name(params[:screen_name])
    @pint = @recipient.pints.new
  end

  def create
    @pint = Pint.create(params[:pint])
  end

  def redeem
    
  end
end
