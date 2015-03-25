class Item < ActiveRecord::Base

  has_many :line_items
  before_destroy :ensure_not_referenced_by_any_line_item

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
  
  def self.advsearch(params)
    if params 
      if params[:match_all] == "1" #implement the AND logic
        find(:all, :conditions => ['name LIKE ? AND description LIKE ? AND quantity LIKE?',"%#{params[:name]}%", "%#{params[:description]}%", "%#{params[:quantity]}%"])
      else
        params.each do |k, v|
          params[k] = "++" if params[k] == "" #by default, if a field is left blank, we can change from the ignore syntax "" to a filler, so that blank fields do not generate all results.
        end
        find(:all, :conditions => ['name LIKE ? OR description LIKE ? OR quantity LIKE?',"%#{params[:name]}%", "%#{params[:description]}%", "%#{params[:quantity]}%"])
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
