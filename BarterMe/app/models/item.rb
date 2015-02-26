class Item < ActiveRecord::Base
searchkick word_start: [:name]
end
