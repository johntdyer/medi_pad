class DoctorsController < ApplicationController
  
  before_filter :require_no_doctor, :only => [:new, :create]
  before_filter :require_doctor, :only => [:show, :edit, :update]

  helper :all
  
  
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
    #Sets favorites to a nill YAML string, needed for favorites
    @doctor.update_attributes(:favorites=>'--- []\n\n')
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
    logger.info("@@@@ #{params[:procedure_code]}")
    @doctor = current_doctor
#    @test = Test.find_by_guid(params[:CallGuid])
#    @test.update_attributes(:call_status=>"Recording Audio")
    
    @doctor = current_doctor

   # count_favorites(params[:procedure_ids],@doctor)

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
  
  def edit_procedure
    @doctor = current_doctor
    favorites = YAML.load(@doctor.favorites)
    
    if params[:commit]=='delete'
        logger.info("@@@@ #{params[:commit]} #{params[:procedure_code]} => #{current_doctor.doctor_name}")

        favorites.delete(params[:procedure_code])        
        @doctor.update_attributes(:favorites=>favorites.to_yaml)
        
      elsif params[:commit]=='add'
        logger.info("@@@@ #{params[:commit]} #{params[:procedure_code]} => #{current_doctor.doctor_name}")
        favorites<<params[:procedure_code]
        @doctor.update_attributes(:favorites=>favorites.to_yaml)

      else
        logger.info "@@@ LOG: Error: edit_procedure, unexpected action param"
        redirect_to "/doctors/#{params[:id]}"
      end
    
    #@doctor.update_attributes(params[])
    redirect_to "/doctors/#{params[:id]}"
    
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
  
  
  private
  
   
=begin rdoc
  Limits favorites to 10
=end
    # def count_favorites(v,doctor)
    #    require 'yaml'
    #    if !v.nil?
    #      logger.info "NO NILL"
    #      doctor.update_attributes(:favorites=>v[0..9].to_yaml)
    #      flash[:notice] = 'Profile updated.'
    #      return true
    #    else
    #      logger.info "@@@ ZERO FAVORITES"
    #      return false
    #    end
    #  end
    
end
