require 'fileutils'
require 'faker'

def create_file(path, extension)
 dir = File.dirname(path)

 unless File.directory?(dir)
   FileUtils.mkdir_p(dir)
  end

 path << ".#{extension}"
 File.new(path, 'w')
end

Category.delete_all
User.delete_all
Item.delete_all



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
  tmp_location[n] = city<<', '<<state
  
  cur_user = User.create(user_name: user_name,
                         password: password,
                         password_confirmation: password,
                         email: email,
                         phone: Faker::PhoneNumber.cell_phone,
                         reliability: rand(10),
                         address: Faker::Address.street_address,
                         city: city,
                         state: state,
                         zip: Faker::Address.zip,
                         admin: false)

  3.times do |n|
    
    product = Faker::Commerce.product_name
    url = "http://placehold.it/150&text="+product
    
    Item.new
    puts Category.offset(rand(Category.count)).first.id
    Item.create(name: product,
                description: Faker::Lorem.paragraph,
                image_url: open("http://www.hollywoodreporter.com/sites/default/files/imagecache/675x380/2014/09/too_good_for_grumpy_cat.jpg"),
                user_id: cur_user.id,
                category_id: Category.offset(rand(Category.count)).first.id,
                location: Faker::Address.street_address,
                quantity: rand(4)+1)
  end
end

User.create(user_name: "admin",
            password: "123",
            password_confirmation: "123",
            email: "admin",
            phone: Faker::PhoneNumber.cell_phone,
            reliability: rand(10),
            address: Faker::Address.street_address,
            city: " ",
            state: " ",
            zip: Faker::Address.zip,
            admin: true)

