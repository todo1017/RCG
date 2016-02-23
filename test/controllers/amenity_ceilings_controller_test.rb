require 'test_helper'

class AmenityCeilingsControllerTest < ActionController::TestCase
  setup do
    @amenity_ceiling = amenity_ceilings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:amenity_ceilings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create amenity_ceiling" do
    assert_difference('AmenityCeiling.count') do
      post :create, amenity_ceiling: { name: @amenity_ceiling.name }
    end

    assert_redirected_to amenity_ceiling_path(assigns(:amenity_ceiling))
  end

  test "should show amenity_ceiling" do
    get :show, id: @amenity_ceiling
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @amenity_ceiling
    assert_response :success
  end

  test "should update amenity_ceiling" do
    patch :update, id: @amenity_ceiling, amenity_ceiling: { name: @amenity_ceiling.name }
    assert_redirected_to amenity_ceiling_path(assigns(:amenity_ceiling))
  end

  test "should destroy amenity_ceiling" do
    assert_difference('AmenityCeiling.count', -1) do
      delete :destroy, id: @amenity_ceiling
    end

    assert_redirected_to amenity_ceilings_path
  end
end
