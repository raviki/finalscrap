require 'test_helper'

class Admin::Customers::CustomerInfosControllerTest < ActionController::TestCase
  test "should get edit" do
    get :edit
    assert_response :success
  end

end
