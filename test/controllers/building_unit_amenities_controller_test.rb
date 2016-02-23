require 'test_helper'

class BuildingUnitAmenitiesControllerTest < ActionController::TestCase
  setup do
    @building_unit_amenity = building_unit_amenities(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:building_unit_amenities)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create building_unit_amenity" do
    assert_difference('BuildingUnitAmenity.count') do
      post :create, building_unit_amenity: { amenity_ceiling_id: @building_unit_amenity.amenity_ceiling_id, amenity_patio_id: @building_unit_amenity.amenity_patio_id, building_id: @building_unit_amenity.building_id, ceiling_: @building_unit_amenity.ceiling_, microwave: @building_unit_amenity.microwave, microwave_: @building_unit_amenity.microwave_, other: @building_unit_amenity.other, other_: @building_unit_amenity.other_, oversized_windows: @building_unit_amenity.oversized_windows, oversized_windows_: @building_unit_amenity.oversized_windows_, patio_: @building_unit_amenity.patio_, security_alarm: @building_unit_amenity.security_alarm, security_alarm_: @building_unit_amenity.security_alarm_, washer_dryer: @building_unit_amenity.washer_dryer, washer_dryer_: @building_unit_amenity.washer_dryer_ }
    end

    assert_redirected_to building_unit_amenity_path(assigns(:building_unit_amenity))
  end

  test "should show building_unit_amenity" do
    get :show, id: @building_unit_amenity
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @building_unit_amenity
    assert_response :success
  end

  test "should update building_unit_amenity" do
    patch :update, id: @building_unit_amenity, building_unit_amenity: { amenity_ceiling_id: @building_unit_amenity.amenity_ceiling_id, amenity_patio_id: @building_unit_amenity.amenity_patio_id, building_id: @building_unit_amenity.building_id, ceiling_: @building_unit_amenity.ceiling_, microwave: @building_unit_amenity.microwave, microwave_: @building_unit_amenity.microwave_, other: @building_unit_amenity.other, other_: @building_unit_amenity.other_, oversized_windows: @building_unit_amenity.oversized_windows, oversized_windows_: @building_unit_amenity.oversized_windows_, patio_: @building_unit_amenity.patio_, security_alarm: @building_unit_amenity.security_alarm, security_alarm_: @building_unit_amenity.security_alarm_, washer_dryer: @building_unit_amenity.washer_dryer, washer_dryer_: @building_unit_amenity.washer_dryer_ }
    assert_redirected_to building_unit_amenity_path(assigns(:building_unit_amenity))
  end

  test "should destroy building_unit_amenity" do
    assert_difference('BuildingUnitAmenity.count', -1) do
      delete :destroy, id: @building_unit_amenity
    end

    assert_redirected_to building_unit_amenities_path
  end
end
