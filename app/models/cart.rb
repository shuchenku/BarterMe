class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy
  belongs_to :user, foreign_key: "user_id"
  
  def add_item(item_id)
    
    current_item = line_items.find_by(item_id: item_id) 
    if !current_item
      current_item = line_items.build(item_id: item_id)
    else
      return -1
    end
    
   return current_item
    
  end
  
  
  
end
