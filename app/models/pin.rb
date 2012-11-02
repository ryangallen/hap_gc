class Pin < ActiveRecord::Base
	attr_accessible :category, :name, :address, :latitude, :longitude, :date, :time, :desc;
	
	geocoded_by :address
	after_validation :geocode, :if => :address_changed?
end