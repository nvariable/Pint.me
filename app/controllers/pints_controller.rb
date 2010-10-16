class PintsController < ApplicationController
  def index
    @pints = Pint.all
  end
end
