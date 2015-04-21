require 'geocoder'
require 'mongoid'


class Location < ActiveRecord::Base
	# include Mongoid::Document

	belongs_to :user
	


	# attr_accessor :coordinates
	# attr_accessor :address
	# include Geocoder::Model::Mongoid


	geocoded_by :address
	after_validation :geocode

	reverse_geocoded_by :latitude, :longitude
	after_validation :reverse_geocode
end
