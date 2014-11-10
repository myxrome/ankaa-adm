require 'test_helper'

class MinerScrapersControllerTest < ActionController::TestCase
  setup do
    @miner_scraper = miner_scraper_relations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:miner_scraper)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create miner_scraper" do
    assert_difference('MinerScraper.count') do
      post :create, miner_scraper: {}
    end

    assert_redirected_to miner_scraper_relation_path(assigns(:miner_scraper))
  end

  test "should show miner_scraper" do
    get :show, id: @miner_scraper
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @miner_scraper
    assert_response :success
  end

  test "should update miner_scraper" do
    patch :update, id: @miner_scraper, miner_scraper: {}
    assert_redirected_to miner_scraper_relation_path(assigns(:miner_scraper))
  end

  test "should destroy miner_scraper" do
    assert_difference('MinerScraper.count', -1) do
      delete :destroy, id: @miner_scraper
    end

    assert_redirected_to miner_scraper_relations_path
  end
end
