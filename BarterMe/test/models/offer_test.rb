require 'test_helper'
require 'pry'
require 'pry-byebug'

class OfferTest < ActiveSupport::TestCase

  # test "the truth" do
  #   assert true
  # end
  test "can create a  new offer" do
  	new_offer = Offer.new
  	assert_instance_of Offer, new_offer
  end

  def setup
    @user1 = User.new(:email=>"xxx@com", :user_name => "haha",:password => "xxx", :password_confirmation => "xxx")
    @user2 = User.new(:email=>"xxx2@com", :user_name => "haha2",:password => "xxx", :password_confirmation => "xxx")
    @user1.save
    @user2.save

    @item1 = Item.new(:user_id => @user1.id, name: "My Item",description: "test item",image_url: "test.jpg",quantity: 5)
    @item2 = Item.new(:user_id => @user2.id, name: "My Item 2", description: "test item 2", image_url: "test2.jpg", quantity: 5)

    @item1.save
    @item2.save
    
  end

  test "one offer must have two users" do

  	offer1 = Offer.new(:user1_id => @user1.id,:item2_id => @item2.id.to_s, :item1_id => @item1.id.to_s)
  	offer2 = Offer.new(:user1_id => @user1.id,:user2_id => @user2.id,:item1_id => @item1.id.to_s,:item2_id => @item2.id.to_s)

  	assert_not offer1.save
  	assert offer2.save
  end

  test "can't barter with yourself" do
    dumboffer = Offer.new(:user1_id => @user1.id,:user2_id => @user1.id, :item1_id => @item1.id.to_s, :item2_id => @item2.id.to_s)
    assert dumboffer.invalid?
    assert_equal ["don't barter with yourself"], dumboffer.errors[:user2_id]
  end

  test "one offer must have two items" do 
  	offer1 = Offer.new(:user1_id => @user1.id,:user2_id => @user2.id, :item1_id => @item1.id.to_s, :item2_id => 'none selected')
  	offer2 = Offer.new(:user1_id => @user1.id,:user2_id => @user2.id,:item1_id => @item1.id.to_s,:item2_id => @item2.id.to_s)

  	assert offer1.invalid?
  	assert offer2.valid?
  end

end
