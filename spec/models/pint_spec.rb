require 'spec_helper'

describe Pint do
  it { should belong_to(:user) }
  it { should belong_to(:business) }
  it { should belong_to(:purchaser) }
end
