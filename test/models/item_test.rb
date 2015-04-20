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

    @category = Category.new(:name=>"c1", :description=>"test c1")
    @category.save

    @product = Item.new(name: "My Item",
                       description: "test item",
                       image_url: "test.jpg",
                       quantity: 5,
                       user_id: @user.id, 
                       category_id: @category.id)
    @productD = Item.new(name: "My Item",
                       description: "test item",
                       image_url: "test.jpg",
                       quantity: 5,
                       user_id: @user.id, 
                       category_id: @category.id)
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
  end

  test "product quantity must be greater than 0" do
    product = Item.new(name: "My Item",
                       description: "test item",
                       image_url: "test.jpg", 
                       user_id: @user.id, 
                       category_id: @category.id)

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

end
