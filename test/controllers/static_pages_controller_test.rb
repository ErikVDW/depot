require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get questions" do
    get :questions
    assert_response :success
  end

  test "should get news" do
    get :news
    assert_response :success
  end

  test "should get contact" do
    get :contact
    assert_response :success
  end

end
