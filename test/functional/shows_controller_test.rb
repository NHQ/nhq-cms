require 'test_helper'

class ShowsControllerTest < ActionController::TestCase
  setup do
    @show = shows(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:shows)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create show" do
    assert_difference('Show.count') do
      post :create, :show => @show.attributes
    end

    assert_redirected_to show_path(assigns(:show))
  end

  test "should show show" do
    get :show, :id => @show.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @show.to_param
    assert_response :success
  end

  test "should update show" do
    put :update, :id => @show.to_param, :show => @show.attributes
    assert_redirected_to show_path(assigns(:show))
  end

  test "should destroy show" do
    assert_difference('Show.count', -1) do
      delete :destroy, :id => @show.to_param
    end

    assert_redirected_to shows_path
  end
end
