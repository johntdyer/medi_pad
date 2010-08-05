require 'test_helper'

class ChargesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:charges)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create charge" do
    assert_difference('Charge.count') do
      post :create, :charge => { }
    end

    assert_redirected_to charge_path(assigns(:charge))
  end

  test "should show charge" do
    get :show, :id => charges(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => charges(:one).to_param
    assert_response :success
  end

  test "should update charge" do
    put :update, :id => charges(:one).to_param, :charge => { }
    assert_redirected_to charge_path(assigns(:charge))
  end

  test "should destroy charge" do
    assert_difference('Charge.count', -1) do
      delete :destroy, :id => charges(:one).to_param
    end

    assert_redirected_to charges_path
  end
end
