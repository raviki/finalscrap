require 'test_helper'

class CustomerManagementsControllerTest < ActionController::TestCase
  setup do
    @customer_management = customer_managements(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:customer_managements)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create customer_management" do
    assert_difference('CustomerManagement.count') do
      post :create, customer_management: { customer_id: @customer_management.customer_id, email: @customer_management.email, mobile_number: @customer_management.mobile_number, name: @customer_management.name, oauth_expires_at: @customer_management.oauth_expires_at, oauth_token: @customer_management.oauth_token, password: @customer_management.password, password_digest: @customer_management.password_digest, password_reset_sent_at: @customer_management.password_reset_sent_at, password_reset_token: @customer_management.password_reset_token, provider: @customer_management.provider, remember_token: @customer_management.remember_token, uid: @customer_management.uid }
    end

    assert_redirected_to customer_management_path(assigns(:customer_management))
  end

  test "should show customer_management" do
    get :show, id: @customer_management
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @customer_management
    assert_response :success
  end

  test "should update customer_management" do
    patch :update, id: @customer_management, customer_management: { customer_id: @customer_management.customer_id, email: @customer_management.email, mobile_number: @customer_management.mobile_number, name: @customer_management.name, oauth_expires_at: @customer_management.oauth_expires_at, oauth_token: @customer_management.oauth_token, password: @customer_management.password, password_digest: @customer_management.password_digest, password_reset_sent_at: @customer_management.password_reset_sent_at, password_reset_token: @customer_management.password_reset_token, provider: @customer_management.provider, remember_token: @customer_management.remember_token, uid: @customer_management.uid }
    assert_redirected_to customer_management_path(assigns(:customer_management))
  end

  test "should destroy customer_management" do
    assert_difference('CustomerManagement.count', -1) do
      delete :destroy, id: @customer_management
    end

    assert_redirected_to customer_managements_path
  end
end
