require 'test_helper'

class AmenityPatiosControllerTest < ActionController::TestCase
  setup do
    @amenity_patio = amenity_patios(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:amenity_patios)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create amenity_patio" do
    assert_difference('AmenityPatio.count') do
      post :create, amenity_patio: { name: @amenity_patio.name }
    end

    assert_redirected_to amenity_patio_path(assigns(:amenity_patio))
  end

  test "should show amenity_patio" do
    get :show, id: @amenity_patio
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @amenity_patio
    assert_response :success
  end

  test "should update amenity_patio" do
    patch :update, id: @amenity_patio, amenity_patio: { name: @amenity_patio.name }
    assert_redirected_to amenity_patio_path(assigns(:amenity_patio))
  end

  test "should destroy amenity_patio" do
    assert_difference('AmenityPatio.count', -1) do
      delete :destroy, id: @amenity_patio
    end

    assert_redirected_to amenity_patios_path
  end
end
