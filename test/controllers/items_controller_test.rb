require 'test_helper'

class ItemsControllerTest < ActionController::TestCase
  setup do
    @item = items(:itemOne)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

# MUST CHECK: SINCE ONE USER CANNOT POST THE SAME PRODUCT TWICE, SO THE ITEM.NAME CANNOT BE THE SAME
# IN THIS TEST, I USED THE FIRST 2 CHARS OF STRING
  test "should create item" do
    assert_difference('Item.count') do
      post :create, item: { id: @item.id, description: @item.description, image_url: @item.image_url, location: @item.location, name: @item.name[0..2], quantity: @item.quantity, user_id: @item.user_id, category_id: @item.category_id }
    end

    assert_redirected_to item_path(assigns(:item))
  end

  test "should show item" do
    get :show, id: @item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @item
    assert_response :success
  end

 test "should update item" do
   patch :update, id: @item, item: {description: @item.description, image_url: @item.image_url, location: @item.location, name: @item.name, quantity: @item.quantity, user_id: @item.user_id, category_id: @item.category_id }
   assert_redirected_to item_path(@item.id)
 end

  test "should destroy item" do
    assert_difference('Item.count', -1) do
      delete :destroy, id: @item
    end

    assert_redirected_to items_path
  end
end
