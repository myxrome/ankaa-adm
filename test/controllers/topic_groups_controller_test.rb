require 'test_helper'

class TopicGroupsControllerTest < ActionController::TestCase
  setup do
    @topic_group = topic_groups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:topic_groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create topic_group" do
    assert_difference('TopicGroup.count') do
      post :create, topic_group: {  }
    end

    assert_redirected_to topic_group_path(assigns(:topic_group))
  end

  test "should show topic_group" do
    get :show, id: @topic_group
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @topic_group
    assert_response :success
  end

  test "should update topic_group" do
    patch :update, id: @topic_group, topic_group: {  }
    assert_redirected_to topic_group_path(assigns(:topic_group))
  end

  test "should destroy topic_group" do
    assert_difference('TopicGroup.count', -1) do
      delete :destroy, id: @topic_group
    end

    assert_redirected_to topic_groups_path
  end
end
