require 'test_helper'

class VirtualContextsControllerTest < ActionController::TestCase
  setup do
    @virtual_context = virtual_contexts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:virtual_contexts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create virtual_context" do
    assert_difference('VirtualContext.count') do
      post :create, virtual_context: {}
    end

    assert_redirected_to virtual_context_path(assigns(:virtual_context))
  end

  test "should show virtual_context" do
    get :show, id: @virtual_context
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @virtual_context
    assert_response :success
  end

  test "should update virtual_context" do
    patch :update, id: @virtual_context, virtual_context: {}
    assert_redirected_to virtual_context_path(assigns(:virtual_context))
  end

  test "should destroy virtual_context" do
    assert_difference('VirtualContext.count', -1) do
      delete :destroy, id: @virtual_context
    end

    assert_redirected_to virtual_contexts_path
  end
end
