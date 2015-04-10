# require 'bcrypt'

class User < ActiveRecord::Base
	serialize :looking_for, Array
	has_many :items, inverse_of: :user
	validates :email, presence: true, uniqueness: true
	validates :user_name, presence: true, uniqueness: true
	mount_uploader :image, ImageUploader
	has_secure_password

  def self.similarity_score(user1, user2)
    owner = User.find_by(:user_name => user1)
    owner_looking_for = looking_for?(owner)
    current_user = user2
    similarity_score = 10
    current_user_items = Item.find(:all, :conditions => ['user_id = ? ', current_user.id])
    current_user_items.each do |item|
      if owner_looking_for.has_key?(item.category.name)
        owner_looking_for[item.category.name] += 1
      end
    end
    owner_looking_for.each_value {|val| similarity_score += val*5 }
    return similarity_score
  end

  def self.best_match(user)
    best_match = Hash.new
    recommendations = Array.new
    user_looking_for = looking_for?(user)
    sorted_match = similar_users(user_looking_for)
    sorted_match[0..10].each do |k, v|
      best_match[k] = (User.similarity_score(k, user))
    end
    sorted_best_match = best_match.sort_by { |k, v| -v }
    sorted_best_match[0..5].each do |k, v|
      matcher_items = Item.mine?(User.find_by(:user_name => k))
      matcher_items.each do |item|
        if user_looking_for.has_key?(item.category.name)
          recommendations.push(item)
        end
      end
    end
    return recommendations
  end

  def self.similar_users(looking_for)
    items = Item.all
    best_users = Hash.new 
    items.each do |item|
      if looking_for.has_key?(item.category.name)
        if best_users.has_key?(item.user.user_name)
          best_users[item.user.user_name] += 1
        else
          best_users[item.user.user_name] = 1
        end
      end
    end
    return best_users.sort_by { |k, v| -v}
  end

  def self.looking_for?(user)
    user_looking_for = Hash.new
    user.looking_for.each do |category|
      if category != ""
        category_name = Category.find(category).name
        user_looking_for[category_name] = 0
      end
    end
    return user_looking_for
  end









	# # users.password_hash in the database is a :string
 #  	include BCrypt

 #  	def password
 #    	@password ||= Password.new(password_hash)
 #  	end

 #  	def password=(new_password)
 #    	@password = Password.create(new_password)
 #    	self.password_hash = @password
 #  	end

	# def login
 #  		@user = User.find_by_email(params[:email])
 #  		if @user.password == params[:password]
 #    		give_token
 #  		else
 #    		redirect_to home_url
 #  		end
	# end

	# # assign them a random one and mail it to them, asking them to change it
	# def forgot_password
	#   @user = User.find_by_email(params[:email])
	#   random_password = Array.new(10).map { (65 + rand(58)).chr }.join
	#   @user.password = random_password
	#   @user.save!
	#   Mailer.create_and_deliver_password_change(@user, random_password)
	# end



	
	# has_and_belongs_to_many :offers, foreign_key: "offer_id"
	
end
