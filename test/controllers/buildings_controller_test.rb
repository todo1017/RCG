require 'test_helper'

class BuildingsControllerTest < ActionController::TestCase
  setup do
    @building = buildings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:buildings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create building" do
    assert_difference('Building.count') do
      post :create, building: { comp_group_id: @building.comp_group_id, description: @building.description, manager: @building.manager, name: @building.name, number_of_units: @building.number_of_units, phone: @building.phone, website: @building.website, year_built: @building.year_built, year_remodeled: @building.year_remodeled }
    end

    assert_redirected_to building_path(assigns(:building))
  end

  test "should show building" do
    get :show, id: @building
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @building
    assert_response :success
  end

  test "should update building" do
    patch :update, id: @building, building: { comp_group_id: @building.comp_group_id, description: @building.description, manager: @building.manager, name: @building.name, number_of_units: @building.number_of_units, phone: @building.phone, website: @building.website, year_built: @building.year_built, year_remodeled: @building.year_remodeled }
    assert_redirected_to building_path(assigns(:building))
  end

  test "should destroy building" do
    assert_difference('Building.count', -1) do
      delete :destroy, id: @building
    end

    assert_redirected_to buildings_path
  end
end
