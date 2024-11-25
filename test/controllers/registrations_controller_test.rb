require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "should create user and redirect to login" do
    assert_difference("User.count") do
      post registrations_path, params: {
        user: {
          email_address: "test@example.com",
          password: "password123",
          password_confirmation: "password123"
        }
      }
    end
    assert_redirected_to new_session_path
    follow_redirect!
    assert_response :success
    assert_select "div.alert.alert-notice", "Account created successfully. Please log in."
  end

  private

  def user_params
    params.require(:user).permit(:email_address, :password, :password_confirmation)
  end
end
