require 'test_helper'

class CompGroupsControllerTest < ActionController::TestCase
  setup do
    @comp_group = comp_groups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:comp_groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create comp_group" do
    assert_difference('CompGroup.count') do
      post :create, comp_group: { name: @comp_group.name }
    end

    assert_redirected_to comp_group_path(assigns(:comp_group))
  end

  test "should show comp_group" do
    get :show, id: @comp_group
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @comp_group
    assert_response :success
  end

  test "should update comp_group" do
    patch :update, id: @comp_group, comp_group: { name: @comp_group.name }
    assert_redirected_to comp_group_path(assigns(:comp_group))
  end

  test "should destroy comp_group" do
    assert_difference('CompGroup.count', -1) do
      delete :destroy, id: @comp_group
    end

    assert_redirected_to comp_groups_path
  end
end
