require 'fileutils'
require 'faker'

def random_category
  return Category.all[rand(Category.all.size-1)].id
end


Category.delete_all
User.delete_all
Item.delete_all
Location.delete_all



#create categories
File.open("db/category.txt").each_line do |line|
  Category.create(name: line.delete("\n"), description: "This is the category " + line)
end

tmp_location = Hash.new
password = 123



10.times do |n|
  user_name = Faker::Name.name
  city = Faker::Address.city
  state = Faker::Address.state
  email = Faker::Internet.email(user_name)
  street = Faker::Address.street_address
  location = street <<', '<<city<<', '<<state
  tmp_location[n] = location
  
  cur_user = User.create(user_name: user_name,
                         password: password,
                         password_confirmation: password,
                         email: email,
                         phone: Faker::PhoneNumber.cell_phone,
                         reliability: rand(10),
                         looking_for: [random_category,random_category,random_category],
                         admin: false)

  cur_location = Location.create(user_id: cur_user.id, address: location)

  3.times do |n|
    
    product = Faker::Commerce.product_name
    url = "http://placehold.it/150&text="+product
    
    Item.new
    Item.create(name: product,
                description: Faker::Lorem.paragraph,
                image_url: open("http://www.hollywoodreporter.com/sites/default/files/imagecache/675x380/2014/09/too_good_for_grumpy_cat.jpg"),
                user_id: cur_user.id,
                category_id: Category.offset(rand(Category.count)).first.id,
                location: Faker::Address.street_address,
                quantity: rand(4)+1)
  end
end

admin = User.create(user_name: "admin",
            password: "123",
            password_confirmation: "123",
            email: "admin",
            phone: Faker::PhoneNumber.cell_phone,
            reliability: rand(10),
            admin: true)
cur_location = Location.create(user_id: admin.id, address: "Brandeis University, Waltham, MA, USA")


