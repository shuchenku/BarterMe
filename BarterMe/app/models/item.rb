class Item < ActiveRecord::Base
<<<<<<< HEAD
=======
	belongs_to :user, foreign_key: "user_id",inverse_of: :items
	# validates :user, presence => true
	validates_presence_of :user
	searchkick word_start: [:name]
>>>>>>> 40b88e9fdbe5abba2c551087594b8dc368f15a9c
end
