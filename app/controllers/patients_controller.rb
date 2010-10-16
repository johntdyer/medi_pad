class PatientsController < ApplicationController
  helper :all
	protect_from_forgery :only => [:update, :destroy]   
	
#  before_filter :require_doctor, :except=>[:create,:index]
	
  # GET /patients
  # GET /patients.xml
  def index
     if Patient.all.length==0                                 
       logger.debug("NO RECORDS")                            
       redirect_to(:controller => "admin", :action => "index")       
     else
       params.each{|i| logger.debug { "@@@@ => #{i}" } }

       @list = Patient.all(:select=>"DISTINCT facility")

       logger.debug { "@@@ current_doctor => #{@current_doctor}" }
       if params.has_key?(:search)
         logger.debug { "SEARCH PRESENT" }
         logger.debug { "" }
         @search = Patient.search(:facility_contains=>params[:id])
       else
         @search = Patient.where(:facility=>@list[0].facility).search(params[:search]) 
       end
      @patients = @search.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @patients }
    end
  end 
end

 
 def search
   @search = Patient.search(:facility_contains=>params[:id])
   @patients=@search.all
   logger.debug { "@@@@ => #{@patients.class}" }
   
   
   render :action => "index"
  end




  # GET /patients/1
  # GET /patients/1.xml
  def show
    @patient = Patient.find(params[:id])

    @favorites = YAML.load(current_doctor.favorites)
 
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @patient }
    end
  end

  # GET /patients/new
  # GET /patients/new.xml
  def new
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
end
