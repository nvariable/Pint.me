class AddLogosToBusinesses < ActiveRecord::Migration
  def self.businesses
    [
      {:name=>'Boneyard Beer', :street_1=>'37 NW Lake Pl', :city=>'Bend', :state=>'OR', :zip=>97701, :company_logo=>'boneyard.jpg'},
      {:name=>'Ten Barrel Brewing Company', :street_1=>'1135 NW Galveston Ave', :city=>'Bend', :state=>'OR', :zip=>97701, :company_logo=>'10barrel.jpeg'},
      {:name=>'Silver Moon Brewing Company', :street_1=>'37 NW Lake Pl', :city=>'Bend', :state=>'OR', :zip=>97701, :company_logo=>'silvermoon.jpeg'},       
    ]
  end
  
  def self.up
    businesses.each{|b| Business.create!(b) }    
    biz= Business.find_by_name('McMenamins Old St. Francis School')
    biz.company_logo='mcmenamins.png' if biz
    biz.save

    biz= Business.find_by_name('The Deschutes Brewery')
    biz.company_logo='deschutes.jpeg' if biz    
    biz.save
  end   

  def self.down
    businesses.each do |b|
      biz= Business.find_by_name(b[:name])
      biz.destroy if biz
    end
  end
end
