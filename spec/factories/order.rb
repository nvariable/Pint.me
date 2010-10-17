Factory.sequence :order_number do |n|
  "order#{n}"
end

Factory.define :order do |p|
  p.association :user, :factory => :user
  p.association :purchaser, :factory => :user
  p.quantity 1
  p.number { Factory.next(:order_number) }
end