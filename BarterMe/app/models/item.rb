class Item < ActiveRecord::Base
searchkick word_start: [:name]
validates :name, :description, :image_url, :post_date, :quantity, presence: true
validates :quantity, numericality: {greater_than: 0}
end
