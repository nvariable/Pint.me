require 'spec_helper'

describe Business do
  context 'associations' do
    it { should have_many :pints }
  end


  context 'validations' do

    it 'should verify that the secret code is a digit' do
      should validate_numericality_of(:secret_code)
    end

    it 'should verify that the secret code is 4 digits' do
      should validate_format_of(:secret_code).with(12340).with_message(/secret_code is invalid/)
    end

    it { should validate_presence_of :name }
    it { should validate_presence_of :street_1 }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
  end

end
