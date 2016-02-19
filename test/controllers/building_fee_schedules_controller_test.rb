require 'test_helper'

class BuildingFeeSchedulesControllerTest < ActionController::TestCase
  setup do
    @building_fee_schedule = building_fee_schedules(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:building_fee_schedules)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create building_fee_schedule" do
    assert_difference('BuildingFeeSchedule.count') do
      post :create, building_fee_schedule: { amenity_fee: @building_fee_schedule.amenity_fee, amenity_fee_: @building_fee_schedule.amenity_fee_, application_fee: @building_fee_schedule.application_fee, application_fee_: @building_fee_schedule.application_fee_, building_id: @building_fee_schedule.building_id, minimum_lease: @building_fee_schedule.minimum_lease, minimum_lease_: @building_fee_schedule.minimum_lease_, monthly_fees: @building_fee_schedule.monthly_fees, monthly_fees_: @building_fee_schedule.monthly_fees_, parking: @building_fee_schedule.parking, parking_: @building_fee_schedule.parking_, parking_extra: @building_fee_schedule.parking_extra, parking_extra_: @building_fee_schedule.parking_extra_, pet_cat: @building_fee_schedule.pet_cat, pet_cat_: @building_fee_schedule.pet_cat_, pet_deposit: @building_fee_schedule.pet_deposit, pet_deposit_: @building_fee_schedule.pet_deposit_, pet_dog: @building_fee_schedule.pet_dog, pet_dog_: @building_fee_schedule.pet_dog_, security_deposit: @building_fee_schedule.security_deposit, security_deposit_: @building_fee_schedule.security_deposit_, trash_fee: @building_fee_schedule.trash_fee, trash_fee_: @building_fee_schedule.trash_fee_, yearly_fees: @building_fee_schedule.yearly_fees, yearly_fees_: @building_fee_schedule.yearly_fees_ }
    end

    assert_redirected_to building_fee_schedule_path(assigns(:building_fee_schedule))
  end

  test "should show building_fee_schedule" do
    get :show, id: @building_fee_schedule
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @building_fee_schedule
    assert_response :success
  end

  test "should update building_fee_schedule" do
    patch :update, id: @building_fee_schedule, building_fee_schedule: { amenity_fee: @building_fee_schedule.amenity_fee, amenity_fee_: @building_fee_schedule.amenity_fee_, application_fee: @building_fee_schedule.application_fee, application_fee_: @building_fee_schedule.application_fee_, building_id: @building_fee_schedule.building_id, minimum_lease: @building_fee_schedule.minimum_lease, minimum_lease_: @building_fee_schedule.minimum_lease_, monthly_fees: @building_fee_schedule.monthly_fees, monthly_fees_: @building_fee_schedule.monthly_fees_, parking: @building_fee_schedule.parking, parking_: @building_fee_schedule.parking_, parking_extra: @building_fee_schedule.parking_extra, parking_extra_: @building_fee_schedule.parking_extra_, pet_cat: @building_fee_schedule.pet_cat, pet_cat_: @building_fee_schedule.pet_cat_, pet_deposit: @building_fee_schedule.pet_deposit, pet_deposit_: @building_fee_schedule.pet_deposit_, pet_dog: @building_fee_schedule.pet_dog, pet_dog_: @building_fee_schedule.pet_dog_, security_deposit: @building_fee_schedule.security_deposit, security_deposit_: @building_fee_schedule.security_deposit_, trash_fee: @building_fee_schedule.trash_fee, trash_fee_: @building_fee_schedule.trash_fee_, yearly_fees: @building_fee_schedule.yearly_fees, yearly_fees_: @building_fee_schedule.yearly_fees_ }
    assert_redirected_to building_fee_schedule_path(assigns(:building_fee_schedule))
  end

  test "should destroy building_fee_schedule" do
    assert_difference('BuildingFeeSchedule.count', -1) do
      delete :destroy, id: @building_fee_schedule
    end

    assert_redirected_to building_fee_schedules_path
  end
end
