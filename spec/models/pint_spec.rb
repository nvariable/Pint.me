require 'spec_helper'

describe Pint do

  context "associations" do
    should belong_to :user
    should belong_to :business
    should belong_to :purchaser
  end

end
