class ApplicationController < ActionController::Base
#  protect_from_forgery
  
  helper :all # include all helpers, all the time
  #helper_method :current_doctor_session, :current_doctor

  
  private
  
  # def current_doctor_session
  #     return @current_doctor_session if defined?(@current_doctor_session)
  # #     @current_doctor_session = DoctorSession.find
  # #   end
  # #   
  #   def current_doctor
  #     return @current_user if defined?(@current_user)
  #   end   
  # #   
  #   def require_user
  #     unless current_user
  #       store_location
  #       flash[:notice] = "You must be logged in to access this page"
  #       redirect_to '/home'
  #       return false
  #     end
  #   end      
  # 
  #   def require_no_doctor
  #     if current_doctor
  #       store_location
  #       flash[:notice] = "You must be logged out to access this page"
  #       redirect_to root_url
  #       return false
  #     end
  # #   end
  # #   
  #   def store_location
  #     session[:return_to] = request.request_uri
  #   end        
  #   
  #   def redirect_back_or_default(default)
  #     redirect_to(session[:return_to] || default)
  #     session[:return_to] = nil
  #   end
  # 
  #   def check_login
  #         if session[:login].blank?
  #           redirect_to :controller => 'patients', :action => 'index'
  #         end
  #   end                  
  
end
