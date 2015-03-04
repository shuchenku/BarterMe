require 'test_helper'
require 'pry'
require 'pry-byebug'
class ItemTest < ActiveSupport::TestCase
  fixtures :items
 test "can create a new product" do
    product = Item.new
    assert_instance_of Item, product
  end

  test "has two products in the database" do
    assert_equal Item.count, 2
  end

  def setup
    @product = Item.new(name: "My Item",
                       description: "test item",
                       image_url: "test.jpg",
                       quantity: 5)
  end

  test "user cannot have duplicate items posted" do
    product1 = Item.first
    product2 = Item.last
    assert product1.invalid?
    assert product2.invalid?
                      
    assert @product.valid?
  end

  test "Can add and delete products from database" do
    assert_equal Item.count, 2

    @product.save
    assert_equal Item.count, 3
    @product.destroy
    assert_equal Item.count, 2
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
                       image_url: "test.jpg")

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

  test "product cannot have duplicate category" do

    @product["category1"] = 1
    assert @product.valid?
    @product["category2"] = 1
    assert @product.invalid?
    @product["category2"] = 2
    assert @product.valid?
    @product["category3"] = 1
    assert @product.invalid?
    @product["category3"] = 2
    assert @product.invalid?
    @product["category3"] = 3
    assert @product.valid?

  end
end
