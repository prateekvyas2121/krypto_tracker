require "test_helper"

class SessionControllerTest < ActionDispatch::IntegrationTest
  test "should get sig_up" do
    get session_sig_up_url
    assert_response :success
  end

  test "should get sign_in" do
    get session_sign_in_url
    assert_response :success
  end
end
