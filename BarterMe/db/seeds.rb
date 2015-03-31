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

User.delete_all
Item.delete_all

create_file('leaked','txt')

tmp_location = Hash.new
to_file = ''



10.times do |n|
  user_name = Faker::Name.name
  password = Faker::Internet.password(4)
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
  
  tmp_str = "Email: "+email+", Password: "+password+"\n"
  to_file = to_file+tmp_str
  
  3.times do |n|
    
    product = Faker::Commerce.product_name
    url = "http://placehold.it/150&text="+product
    
    Item.new
    Item.create(name: product,
                description: Faker::Lorem.paragraph,
                image_url: url,
                user_id: cur_user.id,
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

leaked = open('leaked.txt', 'w')
leaked.write(to_file)
leaked.close

