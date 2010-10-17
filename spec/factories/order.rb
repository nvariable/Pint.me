Factory.define :order do |p|
  p.association :user, :factory => :user
  p.association :purchaser, :factory => :user
  p.quantity 1
end