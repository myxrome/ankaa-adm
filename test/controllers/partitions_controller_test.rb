require 'test_helper'

class PartitionsControllerTest < ActionController::TestCase
  setup do
    @partition = partitions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:partitions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create partition" do
    assert_difference('partition.count') do
      post :create, partition: {}
    end

    assert_redirected_to partition_path(assigns(:partition))
  end

  test "should show partition" do
    get :show, id: @partition
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @partition
    assert_response :success
  end

  test "should update partition" do
    patch :update, id: @partition, partition: {}
    assert_redirected_to partition_path(assigns(:partition))
  end

  test "should destroy partition" do
    assert_difference('partition.count', -1) do
      delete :destroy, id: @partition
    end

    assert_redirected_to partitions_path
  end
end
