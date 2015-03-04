require 'test_helper'
require 'pry'
require 'pry-byebug'

class OfferTest < ActiveSupport::TestCase
  test "can add an new offer and delete it" do
  	assert_equal Offer.count, 2
    new_offer = Offer.new( offer_id: 3,
						user1_id: 3,
  						user2_id: 4,
  						item1_id: 3,
  						item2_id: 4,
  						accepted: false)
    new_offer.save
    assert_equal Offer.count, 3
    new_offer.delete
    assert_equal Offer.count, 2
  end

  test "will not barter with oneself" do
  	dumboffer = offers(:two)
  	assert dumboffer.invalid?
  	assert_equal ["must barter with someone else"], new_offer.errors[:user2_id]
  end

  test "will not give away stuff" do
  	new_offer = Offer.new( offer_id: 3,
						user1_id: 3,
  						user2_id: 4,
  						item1_id: 3,
  						accepted: false)
  	assert new_offer.invalid?
  	assert_equal ["must inquire an item"],new_offer.errors[:item2_id]
  end

   test "will not ask for stuff" do
  	new_offer = Offer.new( offer_id: 3,
						user1_id: 3,
  						user2_id: 4,
  						item2_id: 3,
  						accepted: false)
  	assert new_offer.invalid?
  	assert_equal ["must offer an item"],new_offer.errors[:item1_id]
  end

end
