require 'spec_helper'

describe Pint do
  it { should belong_to(:user) }
  it { should belong_to(:business) }
  it { should belong_to(:purchaser) }

  describe 'callbacks' do
    describe 'after create' do
      before do
        @giver = Factory.create(:user)
        @happy = Factory.create(:user)
      end
      xit 'should increase the senders pints given by one' do
        lambda{
          @pint = Factory.create(:pint, :user => @happy, :purchaser => @giver)
          @pint.save
        }.should change(@giver, :pints_purchased).by(1)
      end
    end
  end
end
