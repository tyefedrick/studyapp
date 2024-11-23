require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    log_in_as(@user)
  end

  test "should create user" do
    post registrations_path, params: {
      user: {
        email_address: "test@example.com",
        password: "password123",
        password_confirmation: "password123"
      }
    }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_equal root_path, path
  end
end
