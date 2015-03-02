class Item < ActiveRecord::Base
  belongs_to :user, foreign_key: "user_id",inverse_of: :items
  # validates :user, presence => true
  validates_presence_of :user
  searchkick word_start: [:name]
end
