require 'test_helper'

class CustomerLeadsControllerTest < ActionController::TestCase
  setup do
    @customer_lead = customer_leads(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:customer_leads)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create customer_lead" do
    assert_difference('CustomerLead.count') do
      post :create, customer_lead: { description: @customer_lead.description, type_name: @customer_lead.type_name }
    end

    assert_redirected_to customer_lead_path(assigns(:customer_lead))
  end

  test "should show customer_lead" do
    get :show, id: @customer_lead
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @customer_lead
    assert_response :success
  end

  test "should update customer_lead" do
    patch :update, id: @customer_lead, customer_lead: { description: @customer_lead.description, type_name: @customer_lead.type_name }
    assert_redirected_to customer_lead_path(assigns(:customer_lead))
  end

  test "should destroy customer_lead" do
    assert_difference('CustomerLead.count', -1) do
      delete :destroy, id: @customer_lead
    end

    assert_redirected_to customer_leads_path
  end
end
