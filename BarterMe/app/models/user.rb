class User < ActiveRecord::Base
	has_many :items, inverse_of: :user
	has_and_belongs_to_many :offers, foreign_key: "offer_id"
end