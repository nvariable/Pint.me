class PintsController < ApplicationController
  def index
    @pints = Pint.all
  end

  def buy
    @recipient = User.create_from_screen_name(params[:screen_name])
  end
end
