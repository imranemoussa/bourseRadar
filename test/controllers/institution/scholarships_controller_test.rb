require "test_helper"

class Institution::ScholarshipsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get institution_scholarships_index_url
    assert_response :success
  end

  test "should get show" do
    get institution_scholarships_show_url
    assert_response :success
  end

  test "should get new" do
    get institution_scholarships_new_url
    assert_response :success
  end

  test "should get create" do
    get institution_scholarships_create_url
    assert_response :success
  end
end
