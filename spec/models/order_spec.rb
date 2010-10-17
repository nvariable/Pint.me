require 'spec_helper'

describe Order do
  before do
    @order = Factory.new(:order)
  end
  context 'Validations' do
    it { should validate_presence_of :user }
    it { should validate_presence_of :purchaser }
    it { should validate_presence_of :quantity }
    it { should validate_presence_of :number }
  end

  context 'callbacks' do
    context 'before create' do
      it 'should generate a unique order number' do
        
      end
    end
  end
end
