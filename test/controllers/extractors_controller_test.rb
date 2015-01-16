require 'test_helper'

class ExtractorsControllerTest < ActionController::TestCase
  setup do
    @extractor = extractors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:extractors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create extractor" do
    assert_difference('Extractor.count') do
      post :create, extractor: {}
    end

    assert_redirected_to extractor_path(assigns(:extractor))
  end

  test "should show extractor" do
    get :show, id: @extractor
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @extractor
    assert_response :success
  end

  test "should update extractor" do
    patch :update, id: @extractor, extractor: {}
    assert_redirected_to extractor_path(assigns(:extractor))
  end

  test "should destroy extractor" do
    assert_difference('Extractor.count', -1) do
      delete :destroy, id: @extractor
    end

    assert_redirected_to extractors_path
  end
end
