require 'test_helper'

class Users::ManagementsControllerTest < ActionController::TestCase
  setup do
    @users_management = users_managements(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users_managements)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create users_management" do
    assert_difference('Users::Management.count') do
      post :create, users_management: { email: @users_management.email, user_id: @users_management.user_id, user_name: @users_management.user_name, user_passwd: @users_management.user_passwd }
    end

    assert_redirected_to users_management_path(assigns(:users_management))
  end

  test "should show users_management" do
    get :show, id: @users_management
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @users_management
    assert_response :success
  end

  test "should update users_management" do
    patch :update, id: @users_management, users_management: { email: @users_management.email, user_id: @users_management.user_id, user_name: @users_management.user_name, user_passwd: @users_management.user_passwd }
    assert_redirected_to users_management_path(assigns(:users_management))
  end

  test "should destroy users_management" do
    assert_difference('Users::Management.count', -1) do
      delete :destroy, id: @users_management
    end

    assert_redirected_to users_managements_path
  end
end
