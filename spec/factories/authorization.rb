Factory.define :authorization do |a|
  a.uid UUID.new.generate.to_s
  a.provider ['facebook', 'twitter', 'openid'].rand
  a.user { Factory(:user) }
end
