Factory.define :business do |b|
  b.name "Test Business"
  b.street_1 "433 NE Irving Ave"
  b.city "Bend"
  b.state "Oregon"
  b.zip "97701"
end

Factory.define :address, :parent=>:business do |a|
  a.name 'Address One'
end

