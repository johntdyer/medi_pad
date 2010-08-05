require 'test_helper'

class ProceduresControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:procedures)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create procedure" do
    assert_difference('Procedure.count') do
      post :create, :procedure => { }
    end

    assert_redirected_to procedure_path(assigns(:procedure))
  end

  test "should show procedure" do
    get :show, :id => procedures(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => procedures(:one).to_param
    assert_response :success
  end

  test "should update procedure" do
    put :update, :id => procedures(:one).to_param, :procedure => { }
    assert_redirected_to procedure_path(assigns(:procedure))
  end

  test "should destroy procedure" do
    assert_difference('Procedure.count', -1) do
      delete :destroy, :id => procedures(:one).to_param
    end

    assert_redirected_to procedures_path
  end
end
