require "test_helper"

class Institution::DashboardsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get institution_dashboards_index_url
    assert_response :success
  end

  test "should get show" do
    get institution_dashboards_show_url
    assert_response :success
  end

  test "should get new" do
    get institution_dashboards_new_url
    assert_response :success
  end

  test "should get create" do
    get institution_dashboards_create_url
    assert_response :success
  end
end
