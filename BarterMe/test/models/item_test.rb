require 'test_helper'
require 'pry'
require 'pry-byebug'

class ItemTest < ActiveSupport::TestCase
  test "has a product in the database" do
    assert Item.count, 1
  end

  test "product attributes must not be empty" do
    product = Item.new
    binding.pry
    assert product.invalid?
    assert product.errors[:name].any?
    assert product.errors[:description].any?
    assert product.errors[:quantity].any?
    assert product.errors[:image_url].any?
    assert product.errors[:post_date].any?
  end
  
  test "product quantity must be greater than 0" do
    product = Item.new(name: "My Item",
                       description: "test item",
                       image_url: "test.jpg",
                       post_date: 4444)

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
