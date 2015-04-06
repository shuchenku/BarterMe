class Category < ActiveRecord::Base
	validates :name, :description, presence: true
end
