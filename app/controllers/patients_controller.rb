class PatientsController < ApplicationController
  helper :all
  protect_from_forgery :only => [:update, :destroy]

  before_filter :authenticate_user!

  # GET /patients
  # GET /patients.xml
  def index
     #distinct list of facilities 
     @list =   Patient.all(:select=>"DISTINCT facility")

     if Patient.all.length==0
       logger.debug("NO RECORDS")
       #redirect_to(:controller => "admin", :action => "index")
       @search = []
     else 

       if params.has_key?(:location)
         @search = Patient.order('patients.room ASC').search(:facility_equals=>params[:location],:discharged_equals=>false).where({:date_last_added.eq=>Time.now.midnight}) 
       else
         
         if params[:date] 
            @selected_time =  Time.at(params[:date].to_i).midnight 
         else
            @selected_time = Time.now.midnight
         end 
         session[:selected_time] = @selected_time


         @search= Patient.order('patients.room ASC').where({
                      :facility.eq=>@list.first.facility.upcase,
                      :discharged.eq=>false,
                      :date_last_added.gte=>@selected_time,
                      :date_last_added.lte=>@selected_time+1.days
                      })
                      
                      #@search = Patient.where(:facility=>@list[0].facility,:discharged=>false).search(params[:search])
                      #@search= Patient.order('patients.room ASC').where(:facility=>'ALTAMONTE',:discharged=>false,:date_last_added.eq=>Time.now.midnight).search(params[:search])#.where({:date_last_added.eq=>Time.now.midnight})  #@search = Patient.where(:facility=>@list[0].facility,:discharged=>false).search(params[:search])
       end

      @patients = @search.all

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
