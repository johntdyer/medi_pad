# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  include Oink::MemoryUsageLogger
  include Oink::InstanceTypeCounter
  
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  helper_method :current_doctor
  private
  
  def current_doctor_session
    return @current_doctor_session if defined?(@current_doctor_session)
    @current_doctor_session = DoctorSession.find
  end
  
  def current_doctor
    return @current_doctor if defined?(@current_doctor)
    @current_doctor = current_doctor_session && current_doctor_session.record
  end
end
