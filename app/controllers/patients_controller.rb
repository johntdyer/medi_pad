class PatientsController < ApplicationController
  helper :all
  protect_from_forgery :only => [:update, :destroy]

  before_filter :authenticate_user!

  # GET /patients
  # GET /patients.xml
  def index
     #Get a list of distinct facilities 
     @list = Patient.all(:select=>"DISTINCT facility")

   if !Patient.last #Patient.all.length==0
       logger.debug("NO RECORDS")
       @search = []
     else

       # If we have a date (passed from the view) we'll use that, otherwise
       # we will set the date to today @ midnight.
     if params[:date] 
       @selected_time = Time.at(params[:date].to_i).midnight 
     else
       @selected_time = Time.now.midnight
     end 

     # Set session cookie so we can track state
     session[:selected_time] = @selected_time

      patient_search=Admission.scoped(
            :conditions => ['checkin >= ? AND checkin < ?', session[:selected_time].to_date, session[:selected_time].to_date+1.day], 
            :include => :patient
          ).map(&:patient).uniq

            #   meta_search_hash = {
            #    :created_at.lte=>DateTime.now,
            #    :created_at.gte=>session[:selected_time],
            #    :date_last_added.gte=>session[:selected_time].midnight,
            #    :date_last_added.lte=>session[:selected_time]+1.days,
            #    :discharged.eq=>false
            #   }

     location = params.has_key?(:location) ? params[:location].upcase : @list.first.facility.upcase 

     if params.has_key?(:location)
        unless params[:location].downcase=='all'   
          @search = Array.new
          patient_search.each{|patient|
            @search<<patient if patient.facility == location
          }
        end

       # meta_search_hash = meta_search_hash.merge({
       #                                                     :facility.eq=>location
       #                                                     }) unless params[:location].downcase=='all'
     else
       @search = patient_search
     end

   #  @search= Patient.where(meta_search_hash).order('patients.room ASC')#.where()

     @patients = @search

     respond_to do |format|
       format.html # index.html.erb
       format.xml  { render :xml => @patients }
       format.json  { render :json => @patients }
     end
   end 
  end

 # def location
 #   @search = Patient.search(:facility_equals=>params[:id],:discharged_equals=>false)
 #   @patients=@search.all#(:discharged=>false)
 #   #logger.debug { "\n\n\n@@@@ => #{@patients.class}\n\n\n" }
 #   #render :action => "index"
 # end    

  # GET /patients/1
  # GET /patients/1.xml
  def show 
          @todays_charges =  Charge.where({
            :created_at.gte=>session[:selected_time].midnight,
            :created_at.lte=>session[:selected_time].midnight+1.day
          })
          
    require 'rbyaml'
    @patient = Patient.find(params[:id])
    @favorites = RbYAML.load(current_user.favorites) 
    @procedure_list = Procedure.find(:all, :order => "procedure_name")
    
    # logger.info("\n\t===> favorites: #{@favorites.to_json}\n") 
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @patient }
    end
  end

  # GET /patients/new
  # GET /patients/new.xml
  def new
    @facilities_list  = Patient.all(:select=>"DISTINCT facility");
    @doctors_list = Patient.all(:select=>"DISTINCT attending_md");


    @patient = Patient.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @patient }
    end
  end

  # GET /patients/1/edit
  def edit
    @patient = Patient.find(params[:id])
  end

  # POST /patients
  # POST /patients.xml
  def create
    @patient = Patient.new(params[:patient])

    respond_to do |format|
      if @patient.save
        format.html { redirect_to(@patient, :notice => 'Patient was successfully created.') }
        format.xml  { render :xml => @patient, :status => :created, :location => @patient }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @patient.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /patients/1
  # PUT /patients/1.xml
  def update
    @patient = Patient.find(params[:id])

    respond_to do |format|
      if @patient.update_attributes(params[:patient])
        format.html { redirect_to(@patient, :notice => 'Patient was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @patient.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /patients/1
  # DELETE /patients/1.xml
  def destroy
    @patient = Patient.find(params[:id])
    @patient.destroy

    respond_to do |format|
      format.html { redirect_to(patients_url) }
      format.xml  { head :ok }
    end
  end 

  def poll
     render(:update) { |page| page.update_time }
  end

end
