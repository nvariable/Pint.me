class AddPlaceholderBusinesses < ActiveRecord::Migration
  def self.businesses
    [{:name=>'Bend Brewing Company',                :street_1=>'1019 NW Brooks St',     :city=>'Bend', :state=>'OR', :zip=>97701},
    {:name=>'The Summit Saloon',                    :street_1=>'125 NW Oregon Ave',     :city=>'Bend', :state=>'OR', :zip=>97701},
    {:name=>'The Deschutes Brewery',                :street_1=>'1044 NW Bond St',       :city=>'Bend', :state=>'OR', :zip=>97701},
    {:name=>'Cascade Lakes Lodge',                  :street_1=>'1441 SW Chandler Ave.', :city=>'Bend', :state=>'OR', :zip=>97702},
    {:name=>'McMenamins Old St. Francis School',    :street_1=>'700 N.W. Bond St.',     :city=>'Bend', :state=>'OR', :zip=>97709},
    {:name=>'Reed Pub',                             :street_1=>'1141 SE Centennial St', :city=>'Bend', :state=>'OR', :zip=>97702},
    {:name=>'Deschutes Brewery Craft Beer Brewer',  :street_1=>'901 SW Simpson Ave',    :city=>'Bend', :state=>'OR', :zip=>97701}]    
  end
  
  def self.up
    businesses.each{|biz| Business.create!(biz) }
  end

  def self.down
    businesses.each do |biz| 
      biz= Business.find_by_name(biz['name'])
      biz.destroy if biz
    end
  end
end
