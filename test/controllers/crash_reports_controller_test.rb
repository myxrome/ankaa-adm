require 'test_helper'

class CrashReportsControllerTest < ActionController::TestCase
  setup do
    @crash_report = crash_reports(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:crash_reports)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create crash_report" do
    assert_difference('CrashReport.count') do
      post :create, crash_report: {}
    end

    assert_redirected_to crash_report_path(assigns(:crash_report))
  end

  test "should show crash_report" do
    get :show, id: @crash_report
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @crash_report
    assert_response :success
  end

  test "should update crash_report" do
    patch :update, id: @crash_report, crash_report: {}
    assert_redirected_to crash_report_path(assigns(:crash_report))
  end

  test "should destroy crash_report" do
    assert_difference('CrashReport.count', -1) do
      delete :destroy, id: @crash_report
    end

    assert_redirected_to crash_reports_path
  end
end
