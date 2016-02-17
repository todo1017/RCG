require 'test_helper'

class BuildingUnitsControllerTest < ActionController::TestCase
  setup do
    @building_unit = building_units(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:building_units)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create building_unit" do
    assert_difference('BuildingUnit.count') do
      post :create, building_unit: { actual_rent: @building_unit.actual_rent, building_id: @building_unit.building_id, lease_expiration: @building_unit.lease_expiration, market_rent: @building_unit.market_rent, move_in: @building_unit.move_in, move_out: @building_unit.move_out, notes: @building_unit.notes, number: @building_unit.number, other_deposit: @building_unit.other_deposit, resident_deposit: @building_unit.resident_deposit, resident_name: @building_unit.resident_name, sq_feet: @building_unit.sq_feet, unit_type_id: @building_unit.unit_type_id }
    end

    assert_redirected_to building_unit_path(assigns(:building_unit))
  end

  test "should show building_unit" do
    get :show, id: @building_unit
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @building_unit
    assert_response :success
  end

  test "should update building_unit" do
    patch :update, id: @building_unit, building_unit: { actual_rent: @building_unit.actual_rent, building_id: @building_unit.building_id, lease_expiration: @building_unit.lease_expiration, market_rent: @building_unit.market_rent, move_in: @building_unit.move_in, move_out: @building_unit.move_out, notes: @building_unit.notes, number: @building_unit.number, other_deposit: @building_unit.other_deposit, resident_deposit: @building_unit.resident_deposit, resident_name: @building_unit.resident_name, sq_feet: @building_unit.sq_feet, unit_type_id: @building_unit.unit_type_id }
    assert_redirected_to building_unit_path(assigns(:building_unit))
  end

  test "should destroy building_unit" do
    assert_difference('BuildingUnit.count', -1) do
      delete :destroy, id: @building_unit
    end

    assert_redirected_to building_units_path
  end
end
