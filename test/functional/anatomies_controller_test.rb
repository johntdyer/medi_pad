require 'test_helper'

class AnatomiesControllerTest < ActionController::TestCase
  setup do
    @anatomy = anatomies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:anatomies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create anatomy" do
    assert_difference('Anatomy.count') do
      post :create, :anatomy => @anatomy.attributes
    end

    assert_redirected_to anatomy_path(assigns(:anatomy))
  end

  test "should show anatomy" do
    get :show, :id => @anatomy.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @anatomy.to_param
    assert_response :success
  end

  test "should update anatomy" do
    put :update, :id => @anatomy.to_param, :anatomy => @anatomy.attributes
    assert_redirected_to anatomy_path(assigns(:anatomy))
  end

  test "should destroy anatomy" do
    assert_difference('Anatomy.count', -1) do
      delete :destroy, :id => @anatomy.to_param
    end

    assert_redirected_to anatomies_path
  end
end
