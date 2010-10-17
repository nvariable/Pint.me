Factory.sequence :email do |n|
  "user#{n}@pintme.com"
end

Factory.sequence :screen_name do |n|
  "user_#{n}"
end

Factory.define :user do |u|
  u.email { Factory.next(:email) }
  u.name Faker::Name.name
  u.token UUID.new.generate.to_s
  u.secret UUID.new.generate.to_s
  u.screen_name { Factory.next(:email) }
end