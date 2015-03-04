class Item < ActiveRecord::Base
	validates :name, :description, :image_url, :quantity, presence: true
	validates :quantity, numericality: {greater_than: 0}
	validates_uniqueness_of :name, scope: :user_id
	belongs_to :user, foreign_key: "user_id",inverse_of: :items
	#	validates_presence_of :user
	searchkick word_start: [:name]

	validate :no_duplicate_category

	def no_duplicate_category 
		if check_duplicate
			errors.add(:base, "cannot have duplicate categories") unless self[:category1].nil? || self[:category2].nil?
		end
	end

	def check_duplicate
		self[:category2] == self[:category1] || self[:category3] == self[:category2] || self[:category3] == self[:category1]
	end

end
