require "test_helper"

class ShowtimesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get showtimes_index_url
    assert_response :success
  end

  test "should get show" do
    get showtimes_show_url
    assert_response :success
  end

  test "should get new" do
    get showtimes_new_url
    assert_response :success
  end

  test "should get create" do
    get showtimes_create_url
    assert_response :success
  end

  test "should get edit" do
    get showtimes_edit_url
    assert_response :success
  end

  test "should get update" do
    get showtimes_update_url
    assert_response :success
  end

  test "should get destroy" do
    get showtimes_destroy_url
    assert_response :success
  end
end
