require 'test_helper'

class GeographiesControllerTest < ActionController::TestCase
  setup do
    @geography = geographies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:geographies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create geography" do
    assert_difference('Geography.count') do
      post :create, geography: { name: @geography.name }
    end

    assert_redirected_to geography_path(assigns(:geography))
  end

  test "should show geography" do
    get :show, id: @geography
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @geography
    assert_response :success
  end

  test "should update geography" do
    patch :update, id: @geography, geography: { name: @geography.name }
    assert_redirected_to geography_path(assigns(:geography))
  end

  test "should destroy geography" do
    assert_difference('Geography.count', -1) do
      delete :destroy, id: @geography
    end

    assert_redirected_to geographies_path
  end
end
