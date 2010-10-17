Factory.sequence :email do |n|
  "user#{n}@pintme.com"
end

Factory.define :user do |u|
  u.email { Factory.next(:email) }
  u.name Faker::Name.name
  u.token UUID.new.generate.to_s
end