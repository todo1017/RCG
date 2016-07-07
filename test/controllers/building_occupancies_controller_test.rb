require 'test_helper'

class BuildingOccupanciesControllerTest < ActionController::TestCase
  setup do
    @building_occupancy = building_occupancies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:building_occupancies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create building_occupancy" do
    assert_difference('BuildingOccupancy.count') do
      post :create, building_occupancy: { as_of_date: @building_occupancy.as_of_date, building_id: @building_occupancy.building_id, leased_rate: @building_occupancy.leased_rate, occupancy_rate: @building_occupancy.occupancy_rate }
    end

    assert_redirected_to building_occupancy_path(assigns(:building_occupancy))
  end

  test "should show building_occupancy" do
    get :show, id: @building_occupancy
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @building_occupancy
    assert_response :success
  end

  test "should update building_occupancy" do
    patch :update, id: @building_occupancy, building_occupancy: { as_of_date: @building_occupancy.as_of_date, building_id: @building_occupancy.building_id, leased_rate: @building_occupancy.leased_rate, occupancy_rate: @building_occupancy.occupancy_rate }
    assert_redirected_to building_occupancy_path(assigns(:building_occupancy))
  end

  test "should destroy building_occupancy" do
    assert_difference('BuildingOccupancy.count', -1) do
      delete :destroy, id: @building_occupancy
    end

    assert_redirected_to building_occupancies_path
  end
end
