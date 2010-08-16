class DoctorSessionsController < ApplicationController
  def new
    @doctor_session = DoctorSession.new
  end
  
  def create
    @doctor_session = DoctorSession.new(params[:doctor_session])
    if @doctor_session.save
      flash[:notice] = "Successfully logged in"
      redirect_to root_url
    else
      render :action => 'new'
    end
  end
  
  def destroy
    @doctor_session = DoctorSession.find(params[:id])
    @doctor_session.destroy
      flash[:notice] = "Successfully logged out"
    redirect_to root_url
  end
end
