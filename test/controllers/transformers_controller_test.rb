require 'test_helper'

class TransformersControllerTest < ActionController::TestCase
  setup do
    @transformer = transformers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:transformers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create transformer" do
    assert_difference('Transformer.count') do
      post :create, transformer: {}
    end

    assert_redirected_to transformer_path(assigns(:transformer))
  end

  test "should show transformer" do
    get :show, id: @transformer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @transformer
    assert_response :success
  end

  test "should update transformer" do
    patch :update, id: @transformer, transformer: {}
    assert_redirected_to transformer_path(assigns(:transformer))
  end

  test "should destroy transformer" do
    assert_difference('Transformer.count', -1) do
      delete :destroy, id: @transformer
    end

    assert_redirected_to transformers_path
  end
end
