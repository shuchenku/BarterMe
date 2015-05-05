class Item < ActiveRecord::Base

  has_many :line_items
  before_destroy :ensure_not_referenced_by_any_line_item

  validates :name, :description, :quantity, presence: true
  validates :quantity, numericality: {greater_than: -1}
  validates_uniqueness_of :name, scope: :user_id
  belongs_to :user, foreign_key: "user_id",inverse_of: :items
  validates_presence_of :user

  belongs_to :category, foreign_key: "category_id"
  validates_presence_of :category

  mount_uploader :image_url, ImageUploader
  searchkick word_start: [:name]
  
  def self.listing
    listings = Hash.new
    Item.all.each do |item|
      if listings.has_key?(item.category.name)
        listings[item.category.name] += 1
      else
        listings[item.category.name] = 1
      end
    end
      sorted_listing = listings.sort_by {|k,v| -v} 
      return sorted_listing
  end
  
  def search_data
    {
      name: name,
      description: description,
      category: category.name
    }
  end
  
  def self.advsearch(params)
    if params 
      if params[:match_all] == "1" #implement the AND logic
        find(:all, :conditions => ['name LIKE ? AND description LIKE ?',"%#{params[:name]}%", "%#{params[:description]}%"])
      else
        params.each do |k, v|
          params[k] = "++" if params[k] == "" #by default, if a field is left blank, we can change from the ignore syntax "" to a filler
        end
        find(:all, :conditions => ['name LIKE ? OR description LIKE ?',"%#{params[:name]}%", "%#{params[:description]}%"])
      end
    else
      find(:all) 
    end
  end

  def self.mine?(user)
    @items  = Item.where(:user_id => user.id)
  end

 private

 # ensure that there are no line items referencing this product???????????
 def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      return true
    else
      errors.add(:base, 'Line Items present')
      return false
    end
  end

end
