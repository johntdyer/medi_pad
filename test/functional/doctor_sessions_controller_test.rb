require 'test_helper'

class DoctorSessionsControllerTest < ActionController::TestCase
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    DoctorSession.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    DoctorSession.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to root_url
  end
  
  def test_destroy
    doctor_session = DoctorSession.first
    delete :destroy, :id => doctor_session
    assert_redirected_to root_url
    assert !DoctorSession.exists?(doctor_session.id)
  end
end
