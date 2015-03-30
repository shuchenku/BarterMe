require 'test_helper'
require 'pry'
require 'pry-byebug'
class ItemTest < ActiveSupport::TestCase
  fixtures :items
 test "can create a new product" do
    product = Item.new
    assert_instance_of Item, product
  end

  test "has three products in the database" do
    assert_equal Item.count, 3
  end

  def setup
    @user = User.new(:email=>"xxx@com", :user_name => "haha",:password => "xxx", :password_confirmation => "xxx")
    @user.save
    @product = Item.new(name: "My Item",
                       description: "test item",
                       image_url: "test.jpg",
                       quantity: 5,
                       user_id: @user.id)
    @productD = Item.new(name: "My Item",
                       description: "test item",
                       image_url: "test.jpg",
                       quantity: 5,
                       user_id: @user.id)
  end

  test "user cannot have duplicate items posted" do
    assert @product.save
    assert_not @productD.save
  end

  test "Can add and delete products from database" do
    assert_equal Item.count, 3

    @product.save
    assert_equal Item.count, 4
    @product.destroy
    assert_equal Item.count, 3
  end

  test "product attributes must not be empty" do
    product = Item.new
    assert product.invalid?
    assert product.errors[:name].any?
    assert product.errors[:description].any?
    assert product.errors[:quantity].any?
    assert product.errors[:image_url].any?
  end

  test "product quantity must be greater than 0" do
    product = Item.new(name: "My Item",
                       description: "test item",
                       image_url: "test.jpg", 
                       user_id: @user.id)

    product.quantity = 0
    assert product.invalid?
    assert_equal ["must be greater than 0"],
    product.errors[:quantity]

    product.quantity = -1
    assert product.invalid?
    assert_equal ["must be greater than 0"],
    product.errors[:quantity]

    product.quantity = 1
    assert product.valid?
  end

  # test "product cannot have duplicate category" do

  #   @product["category1"] = 1
  #   assert @product.valid?
  #   @product["category2"] = 1
  #   assert @product.invalid?
  #   @product["category2"] = 2
  #   assert @product.valid?
  #   @product["category3"] = 1
  #   assert @product.invalid?
  #   @product["category3"] = 2
  #   assert @product.invalid?
  #   @product["category3"] = 3
  #   assert @product.valid?

  # end
end
