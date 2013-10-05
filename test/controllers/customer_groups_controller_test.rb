require 'test_helper'

class CustomerGroupsControllerTest < ActionController::TestCase
  setup do
    @customer_group = customer_groups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:customer_groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create customer_group" do
    assert_difference('CustomerGroup.count') do
      post :create, customer_group: { description: @customer_group.description, permission_level: @customer_group.permission_level }
    end

    assert_redirected_to customer_group_path(assigns(:customer_group))
  end

  test "should show customer_group" do
    get :show, id: @customer_group
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @customer_group
    assert_response :success
  end

  test "should update customer_group" do
    patch :update, id: @customer_group, customer_group: { description: @customer_group.description, permission_level: @customer_group.permission_level }
    assert_redirected_to customer_group_path(assigns(:customer_group))
  end

  test "should destroy customer_group" do
    assert_difference('CustomerGroup.count', -1) do
      delete :destroy, id: @customer_group
    end

    assert_redirected_to customer_groups_path
  end
end
