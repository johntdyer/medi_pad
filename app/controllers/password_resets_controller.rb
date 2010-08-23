class PasswordResetsController < ApplicationController
  # Method from: http://github.com/binarylogic/authlogic_example/blob/master/app/controllers/application_controller.rb
  before_filter :require_no_doctor
  before_filter :load_doctor_using_perishable_token, :only => [ :edit, :update ]

  def new
  end

  def create
    @doctor = Doctor.find_by_email(params[:email])
    if @doctor
      @doctor.deliver_password_reset_instructions!
      flash[:notice] = "Instructions to reset your password have been emailed to you"
      redirect_to root_path
    else
      flash[:error] = "No user was found with email address #{params[:email]}"
      render :action => :new
    end
  end

  def edit
  end

  def update
    @doctor.password = params[:doctor][:password]
    @doctor.password_confirmation = params[:doctor][:password_confirmation]
    logger.debug { "@@@@-> " + params[:doctor][:password]  }     


    if @doctor.save
      flash[:success] = "Your password was successfully updated"
      redirect_to root_url

    else
      render :action => :edit
    end
  end


  private

  def load_doctor_using_perishable_token
    @doctor = Doctor.find_using_perishable_token(params[:id])
    unless @doctor
      flash[:error] = "We're sorry, but we could not locate your account"
      redirect_to root_url
    end
  end
end