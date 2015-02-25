# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



require 'faker'

User.delete_all
#...

tmp_users = Hash.new
tmp_location = Hash.new

200.times do |n|
	user_name = Faker::Name.name
	user_id = Faker::Number.number(8)
	city = Faker::Address.city
	state = Faker::Address.state
	tmp_location[n] = city<<', '<<state

	tmp_users[n] = user_id
	User.create(user_id: Faker::Number.number(10),
		user_name: user_name,
		email: Faker::Internet.email(user_name),
		phone: Faker::PhoneNumber.cell_phone,
		reliability: rand(10),
		address: Faker::Address.street_address,
		city: city,
		state: state,
		zip: Faker::Address.zip)

end
#...

Item.delete_all
#...

200.times do |n|
	Item.create(name: Faker::Commerce.product_name,
		description: Faker::Lorem.paragraph,
		image_url: Faker::Internet.url('barterme.com'),
		user_id: tmp_users[n],
		product_key: Faker::Number.number(10),
		type_id: Faker::Number.number(3),
		location: tmp_location[n],
		quantity: rand(5))
end



     # t.string :name
     #  t.text :description
     #  t.string :image_url
     #  t.integer :user_id
     #  t.integer :product_key
     #  t.integer :type_id
     #  t.string :location
     #  t.integer :quantity
     #  t.integer :post_date