# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  
  helper :all # include all helpers, all the time
  helper_method :current_doctor_session, :current_doctor
  #filter_parameter_logging :password, :password_confirmation
  
  
  
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  include Oink::MemoryUsageLogger
  include Oink::InstanceTypeCounter
  
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  private
  
  def current_doctor_session
    return @current_doctor_session if defined?(@current_doctor_session)
    @current_doctor_session = DoctorSession.find
  end
  
  def current_doctor
    return @current_doctor if defined?(@current_doctor)
    @current_doctor = current_doctor_session && current_doctor_session.record
  end
  
  def require_doctor
    unless current_doctor
      store_location
      flash[:notice] = "You must be logged in to access this page"
      redirect_to new_doctor_session_url
      return false
    end
  end

  def require_no_doctor
    if current_doctor
      store_location
      flash[:notice] = "You must be logged out to access this page"
      redirect_to root
      return false
    end
  end
  
  def store_location
    session[:return_to] = request.request_uri
  end
  
  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

  def check_login
        if session[:login].blank?
          redirect_to :controller => 'patients', :action => 'index'
        end
  end  
  
end
