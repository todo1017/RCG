require 'test_helper'

class AmenityConciergesControllerTest < ActionController::TestCase
  setup do
    @amenity_concierge = amenity_concierges(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:amenity_concierges)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create amenity_concierge" do
    assert_difference('AmenityConcierge.count') do
      post :create, amenity_concierge: { name: @amenity_concierge.name }
    end

    assert_redirected_to amenity_concierge_path(assigns(:amenity_concierge))
  end

  test "should show amenity_concierge" do
    get :show, id: @amenity_concierge
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @amenity_concierge
    assert_response :success
  end

  test "should update amenity_concierge" do
    patch :update, id: @amenity_concierge, amenity_concierge: { name: @amenity_concierge.name }
    assert_redirected_to amenity_concierge_path(assigns(:amenity_concierge))
  end

  test "should destroy amenity_concierge" do
    assert_difference('AmenityConcierge.count', -1) do
      delete :destroy, id: @amenity_concierge
    end

    assert_redirected_to amenity_concierges_path
  end
end
