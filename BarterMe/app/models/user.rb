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
    owner_looking_for = Hash.new
    owner.looking_for.each do |category|
      category_name = Category.find(category).name
      owner_looking_for[category_name] = 0
    end
    current_user = user2
    similarity_score = 10
    current_user_items = Item.find(:all, :conditions => ['user_id LIKE ? ', "%#{current_user.id}%"])
    current_user_items.each do |item|
      if owner_looking_for.has_key?(item.category.name)
        owner_looking_for[item.category.name] += 1
      end
    end
    owner_looking_for.each_value {|val| similarity_score += val*5 }
    return similarity_score
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
