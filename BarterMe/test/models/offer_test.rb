require 'test_helper'
require 'pry'
require 'pry-byebug'

class OfferTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "can create a new offer" do
  	new_offer = Offer.new
  	assert_instance_of Offer, new_offer
  end


  test "one offer must have two users" do

    user1 = User.new(:user_id => 1, :email=>"xxx@com", :user_name => "haha",:password => "xxx", :password_confirmation => "xxx")
    user2 = User.new(:user_id => 2,:email=>"xxx2@com", :user_name => "haha2",:password => "xxx", :password_confirmation => "xxx")

    item1 = Item.new(item_id: 1, :user_id => 1, name: "My Item",description: "test item",image_url: "test.jpg",quantity: 5,post_date: 4444)
    item2 = Item.new(item_id: 2, :user_id => 1, name: "My Item 2", description: "test item 2", image_url: "test2.jpg", quantity: 5, post_date: 4444)
  	
  	offer1 = Offer.new(:user1_id => 1,:item1_id => 1,:item1_id => 2)
  	offer2 = Offer.new(:user1_id => 1,:user2_id => 2,:item1_id => 1,:item1_id => 2)
  	assert_not offer1.save
  	assert offer2.save
  end

  # test "one offer must have two items" do 
  # 	item1 = Item.new(item_id: 1, 
  # 						name: "My Item",
  #                       description: "test item",
  #                       image_url: "test.jpg",
  #                       quantity: 5,
  #                       post_date: 4444)
  # 	item2 = Item.new(item_id: 2, 
  # 						name: "My Item 2",
  #                       description: "test item",
  #                       image_url: "test.jpg",
  #                       quantity: 5,
  #                       post_date: 4444)
  # 	user1 = User.new(:user_id => 1)
  # 	user2 = User.new(:user_id => 2)

  # 	item1.save
  # 	item2.save
  # 	user1.save
  # 	user2.save

  # 	offer1 = Offer.new(:user1_id => 1,:user2_id => 2, :item1_id => 1)
  # 	offer2 = Offer.new(:user1_id => 1,:user2_id => 2,:item1_id => 1,:item1_id => 2)
  # 	assert offer1.invalid?
  # 	assert offer2.valid?
  # end

end
