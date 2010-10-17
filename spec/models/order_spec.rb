require 'spec_helper'

describe Order do
  before do
    @order = Factory.new(:order)
    @order.stub!(:tweetie)
  end
  context 'Validations' do
    it { should validate_presence_of :user }
    it { should validate_presence_of :purchaser }
    it { should validate_presence_of :quantity }
    it { should validate_presence_of :number }
  end

  context 'complete payment' do
    it 'should set the date paid attirbute' do
      @order.send_pints
      @order.date_paid.should_not be_nil
    end
    it 'should increase pints' do
      @order2 = Factory.create(:order)
      @order2.stub!(:tweetie)
      lambda{
        @order2.send_pints
      }.should change(Pint, :count).by(1)
    end
  end

  context 'class methods' do
    it 'should give a pint price in pennies' do
      Order.respond_to?(:pint_price).should be_true
    end
  end
end
