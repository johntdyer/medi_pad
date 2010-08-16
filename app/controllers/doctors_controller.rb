class DoctorsController < ApplicationController
  
  before_filter :require_no_doctor, :only => [:new, :create]
  before_filter :require_doctor, :only => [:show, :edit, :update]
  
  
  # GET /doctors
  # GET /doctors.xml
  def index
    @doctors = Doctor.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @doctors }
    end
  end

  # GET /doctors/1
  # GET /doctors/1.xml
  def show
    @doctor = Doctor.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @doctor }
    end
  end

  # GET /doctors/new
  # GET /doctors/new.xml
  def new
    @doctor = Doctor.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @doctor }
    end
  end

  # GET /doctors/1/edit
  def edit
    #@doctor = Doctor.find(params[:id])
    @doctor = current_doctor
    
  end

  # POST /doctors
  # POST /doctors.xml
  def create
    @doctor = Doctor.new(params[:doctor])

    respond_to do |format|
      if @doctor.save
        format.html { 
          flash[:notice] = 'Registration Successful.'
          redirect_to root_url 

          }
        format.xml  { render :xml => @doctor, :status => :created, :location => @doctor }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @doctor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /doctors/1
  # PUT /doctors/1.xml
  def update

    # @doctor = Doctor.find(params[:id])
    @doctor = current_doctor
    respond_to do |format|
      if @doctor.update_attributes(params[:doctor])
        format.html { 
          flash[:notice] = 'Profile updated.'
          redirect_to root_url
          }  
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @doctor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /doctors/1
  # DELETE /doctors/1.xml
  def destroy
    @doctor = Doctor.find(params[:id])
    @doctor.destroy

    respond_to do |format|
      format.html { redirect_to(doctors_url) }
      format.xml  { head :ok }
    end
  end
end
