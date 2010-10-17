require 'spec_helper'

describe Order do
  context 'Validations' do
    it { should validate_presence_of :user }
    it { should validate_presence_of :purchaser }
    it { should validate_presence_of :quantity }
  end
end
