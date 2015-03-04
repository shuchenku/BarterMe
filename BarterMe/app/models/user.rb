# require 'bcrypt'

class User < ActiveRecord::Base
	has_many :items, inverse_of: :user
	validates :email, presence: true, uniqueness: true
	validates :user_name, presence: true, uniqueness: true
	
	has_secure_password
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