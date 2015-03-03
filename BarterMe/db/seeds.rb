# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'fileutils'
require 'faker'

#def create_file(path, extension)
 # dir = File.dirname(path)

 # unless File.directory?(dir)
  #  FileUtils.mkdir_p(dir)
  #end

#  path << ".#{extension}"
#  File.new(path, 'w')
#end

#User.delete_all
#...

#create_file('leaked','txt')

#tmp_users = Hash.new
#tmp_location = Hash.new
#to_file = ''

#200.times do |n|
#	user_name = Faker::Name.name
#	user_id = n
#	password = Faker::Internet.password(4)
#	city = Faker::Address.city
#	state = Faker::Address.state
#	email = Faker::Internet.email(user_name)
#	tmp_location[n] = city<<', '<<state

#	tmp_users[n] = user_id
#	User.create(user_id: user_id,
#		user_name: user_name,
#		password: password,
#		password_confirmation: password,
#		email: email,
#		phone: Faker::PhoneNumber.cell_phone,
#		reliability: rand(10),
#		address: Faker::Address.street_address,
#		city: city,
#		state: state,
#		zip: Faker::Address.zip)

#	tmp_str = "Email: "+email+", Password: "+password+"\n"
#	to_file = to_file+tmp_str
#end

#leaked = open('leaked.txt', 'w')
#leaked.write(to_file)
#leaked.close



Item.delete_all
#...

200.times do |n|
  Item.new
	Item.create(name: Faker::Commerce.product_name,
		description: Faker::Lorem.paragraph,
		image_url: Faker::Internet.url('barterme.com'),
		user_id: Faker::Number.number(8),
		product_key: Faker::Number.number(8),
		type_id: Faker::Number.number(3),
		location: Faker::Address.street_address,
		quantity: rand(4)+1)
end

