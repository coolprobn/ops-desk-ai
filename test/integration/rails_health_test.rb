require "test_helper"

class RailsHealthTest < ActionDispatch::IntegrationTest
  test "show is public" do
    get up_path
    assert_response :success
  end
end
