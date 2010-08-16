class DoctorSessionsController < ApplicationController
  before_filter :require_no_doctor, :only => [:new, :create]
  before_filter :require_doctor, :only => :destroy
  

  def new
    @doctor_session = DoctorSession.new
  end
  
  def create
    @doctor_session = DoctorSession.new(params[:doctor_session])
    if @doctor_session.save
      flash[:notice] = "Successfully logged in"
      redirect_to "/patients"
    else
      render :action => 'new'
    end
  end
  
  def destroy
    @doctor_session = DoctorSession.find(params[:id])
    @doctor_session.destroy
      flash[:notice] = "Successfully logged out"
      redirect_to "/patients"
  end
end
