Factory.define :pint do |p|
  p.association :user, :factory => :user
  p.association :purchaser, :factory => :user
end