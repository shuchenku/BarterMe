require 'test_helper'
require 'pry'
require 'pry-byebug'

class UserTest < ActiveSupport::TestCase

  test "can create a new user" do
    user = User.new
    assert_instance_of User, product
  end

  test "has two new users in database" do
  	assert_equal User.count 2
  end 

  test "there cannot be two new users" do
    user = User.first
    user2 = User.last
    assert user.invalid?
    assert user2.invalid?
    
    user3 = Item.new(name: "User user",
                      description: "user u",
                      email: "user@user.com",
    				          phone: "11111111",
    				          reliability: rand(10))
    assert user3.valid? 
    
  end
    
  test "Can add and delete users from database" do
    assert_equal User.count, 2
    user3 = Item.new(name: "User user",
                    description: "user u",
                       email: "user@user.com",
    				           phone: "11111111",
    				reliability: rand(10))
    user.save
    assert_equal User.count, 3
    User.destroy
    assert_equal User.count, 2
  end
  
  test "user attributes must not be empty" do
    person = User.new
    assert person.invalid?
    assert person.errors[:name].any?
    assert person.errors[:description].any?
    assert person.errors[:email].any?
    assert person.errors[:phone].any?
    assert person.errors[:reliability].any?
  end
  
=======
>>>>>>> 3c2a1ee5166e4a4742d8c473ed546c1a9306e332
>>>>>>> 77345359239c8d6f54681a79b08e2b2be5ec0372
end
