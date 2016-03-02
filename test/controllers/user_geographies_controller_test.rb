require 'test_helper'

class UserGeographiesControllerTest < ActionController::TestCase
  setup do
    @user_geography = user_geographies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_geographies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_geography" do
    assert_difference('UserGeography.count') do
      post :create, user_geography: { access_type: @user_geography.access_type, geography_id: @user_geography.geography_id, user_id: @user_geography.user_id }
    end

    assert_redirected_to user_geography_path(assigns(:user_geography))
  end

  test "should show user_geography" do
    get :show, id: @user_geography
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_geography
    assert_response :success
  end

  test "should update user_geography" do
    patch :update, id: @user_geography, user_geography: { access_type: @user_geography.access_type, geography_id: @user_geography.geography_id, user_id: @user_geography.user_id }
    assert_redirected_to user_geography_path(assigns(:user_geography))
  end

  test "should destroy user_geography" do
    assert_difference('UserGeography.count', -1) do
      delete :destroy, id: @user_geography
    end

    assert_redirected_to user_geographies_path
  end
end
