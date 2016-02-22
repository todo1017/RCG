require 'test_helper'

class BuildingAmenitiesControllerTest < ActionController::TestCase
  setup do
    @building_amenity = building_amenities(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:building_amenities)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create building_amenity" do
    assert_difference('BuildingAmenity.count') do
      post :create, building_amenity: { building_id: @building_amenity.building_id, business_center: @building_amenity.business_center, business_center_: @building_amenity.business_center_, concierge: @building_amenity.concierge, concierge_: @building_amenity.concierge_, extra_11: @building_amenity.extra_11, extra_11_: @building_amenity.extra_11_, extra_11_name: @building_amenity.extra_11_name, extra_12: @building_amenity.extra_12, extra_12_: @building_amenity.extra_12_, extra_12_name: @building_amenity.extra_12_name, extra_1: @building_amenity.extra_1, extra_1_: @building_amenity.extra_1_, extra_1_name: @building_amenity.extra_1_name, extra_2: @building_amenity.extra_2, extra_2_: @building_amenity.extra_2_, extra_2_name: @building_amenity.extra_2_name, extra_3: @building_amenity.extra_3, extra_3_: @building_amenity.extra_3_, extra_3_name: @building_amenity.extra_3_name, fitness: @building_amenity.fitness, fitness_: @building_amenity.fitness_, gated: @building_amenity.gated, gated_: @building_amenity.gated_, other: @building_amenity.other, pool: @building_amenity.pool, pool_: @building_amenity.pool_, recreation: @building_amenity.recreation, recreation_: @building_amenity.recreation_, resident_lounge: @building_amenity.resident_lounge, resident_lounge_: @building_amenity.resident_lounge_, rooftop_deck: @building_amenity.rooftop_deck, rooftop_deck_: @building_amenity.rooftop_deck_, screening_room: @building_amenity.screening_room, screening_room_: @building_amenity.screening_room_, train_station: @building_amenity.train_station, train_station_: @building_amenity.train_station_ }
    end

    assert_redirected_to building_amenity_path(assigns(:building_amenity))
  end

  test "should show building_amenity" do
    get :show, id: @building_amenity
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @building_amenity
    assert_response :success
  end

  test "should update building_amenity" do
    patch :update, id: @building_amenity, building_amenity: { building_id: @building_amenity.building_id, business_center: @building_amenity.business_center, business_center_: @building_amenity.business_center_, concierge: @building_amenity.concierge, concierge_: @building_amenity.concierge_, extra_11: @building_amenity.extra_11, extra_11_: @building_amenity.extra_11_, extra_11_name: @building_amenity.extra_11_name, extra_12: @building_amenity.extra_12, extra_12_: @building_amenity.extra_12_, extra_12_name: @building_amenity.extra_12_name, extra_1: @building_amenity.extra_1, extra_1_: @building_amenity.extra_1_, extra_1_name: @building_amenity.extra_1_name, extra_2: @building_amenity.extra_2, extra_2_: @building_amenity.extra_2_, extra_2_name: @building_amenity.extra_2_name, extra_3: @building_amenity.extra_3, extra_3_: @building_amenity.extra_3_, extra_3_name: @building_amenity.extra_3_name, fitness: @building_amenity.fitness, fitness_: @building_amenity.fitness_, gated: @building_amenity.gated, gated_: @building_amenity.gated_, other: @building_amenity.other, pool: @building_amenity.pool, pool_: @building_amenity.pool_, recreation: @building_amenity.recreation, recreation_: @building_amenity.recreation_, resident_lounge: @building_amenity.resident_lounge, resident_lounge_: @building_amenity.resident_lounge_, rooftop_deck: @building_amenity.rooftop_deck, rooftop_deck_: @building_amenity.rooftop_deck_, screening_room: @building_amenity.screening_room, screening_room_: @building_amenity.screening_room_, train_station: @building_amenity.train_station, train_station_: @building_amenity.train_station_ }
    assert_redirected_to building_amenity_path(assigns(:building_amenity))
  end

  test "should destroy building_amenity" do
    assert_difference('BuildingAmenity.count', -1) do
      delete :destroy, id: @building_amenity
    end

    assert_redirected_to building_amenities_path
  end
end
