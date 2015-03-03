class Item < ActiveRecord::Base
	validates :name, :description, :image_url, :post_date, :quantity, presence: true
	validates :quantity, numericality: {greater_than: 0}
	validates_uniqueness_of :name, scope: :user_id
	belongs_to :user, foreign_key: "user_id",inverse_of: :items
#	validates_presence_of :user
searchkick word_start: [:name]

end
