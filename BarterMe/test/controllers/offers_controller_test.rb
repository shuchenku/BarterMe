require 'test_helper'

class OffersControllerTest < ActionController::TestCase
  setup do
    @offer = offers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:offers)
  end

  # test "should get new" do
  #   get :new
  #   assert_response :success
  # end

  test "should create offer" do
    assert_equal Offer.count, 2
    assert_difference('Offer.count') do
      post :create, offer: { accepted: @offer.accepted, item1_id: @offer.item1_id, item2_id: @offer.item2_id, user1_id: @offer.user1_id, user2_id: @offer.user2_id }
    end

    assert_redirected_to offer_path(assigns(:offer))
  end

  test "should show offer" do
    get :show, id: @offer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @offer
    assert_response :success
  end

  test "should update offer" do
    patch :update, id: @offer, offer: { accepted: @offer.accepted, item1_id: @offer.item1_id, item2_id: @offer.item2_id, user1_id: @offer.user1_id, user2_id: @offer.user2_id }
    assert_redirected_to offer_path(assigns(:offer))
  end

  test "should destroy offer" do
    assert_difference('Offer.count', -1) do
      delete :destroy, id: @offer
    end

    assert_redirected_to offers_path
  end
end
