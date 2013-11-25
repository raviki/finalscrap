require 'test_helper'

class Admin::DbuploadControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
