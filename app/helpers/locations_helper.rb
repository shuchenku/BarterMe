module LocationsHelper
	def has_location?(user_id)
		location = Location.find_by user_id: user_id.to_i
		return !location.nil?
	end
end
