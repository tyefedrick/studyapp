require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get registrations_new_url
    assert_response :success
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

  private

  def user_params
    params.require(:user).permit(:email_address, :password, :password_confirmation)
  end
end
