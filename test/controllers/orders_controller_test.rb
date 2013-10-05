require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  setup do
    @order = orders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:orders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create order" do
    assert_difference('Order.count') do
      post :create, order: { active: @order.active, appointment_date: @order.appointment_date, customer_id: @order.customer_id, discount: @order.discount, discount_message: @order.discount_message, duration_inHrs: @order.duration_inHrs, payment_id: @order.payment_id, voucher_id: @order.voucher_id }
    end

    assert_redirected_to order_path(assigns(:order))
  end

  test "should show order" do
    get :show, id: @order
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @order
    assert_response :success
  end

  test "should update order" do
    patch :update, id: @order, order: { active: @order.active, appointment_date: @order.appointment_date, customer_id: @order.customer_id, discount: @order.discount, discount_message: @order.discount_message, duration_inHrs: @order.duration_inHrs, payment_id: @order.payment_id, voucher_id: @order.voucher_id }
    assert_redirected_to order_path(assigns(:order))
  end

  test "should destroy order" do
    assert_difference('Order.count', -1) do
      delete :destroy, id: @order
    end

    assert_redirected_to orders_path
  end
end
