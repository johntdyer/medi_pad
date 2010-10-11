class ChargesController < ApplicationController
  
    before_filter :require_doctor
      require 'json'
  
  
  
  # GET /charges
  # GET /charges.xml
  def index
    @charges = Charge.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @charges }
    end
  end

  # GET /charges/1
  # GET /charges/1.xml
  def show
    @charge = Charge.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @charge }
    end
  end

  # GET /charges/new
  # GET /charges/new.xml
  def new
    @charge = Charge.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @charge }
    end
  end

  # GET /charges/1/edit
  def edit
    @charge = Charge.find(params[:id])
  end

  # POST /charges
  # POST /charges.xml
  def create

    @charge = Charge.new(params[:charge])
    respond_to do |format|
      if @charge.save
        format.html { 
          #	redirect_to(@charge, :notice => 'Charge was successfully created.') 
          redirect_to "/patients/#{@charge.patient_id}"
        }
        format.xml  { render :xml => @charge, :status => :created, :location => @charge }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @charge.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /charges/1
  # PUT /charges/1.xml
  def update
    @charge = Charge.find(params[:id])

    respond_to do |format|
      if @charge.update_attributes(params[:charge])
        format.html { redirect_to(@charge, :notice => 'Charge was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @charge.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /charges/1
  # DELETE /charges/1.xml
  def destroy
    @charge = Charge.find(params[:id])
    @charge.destroy

    respond_to do |format|
      format.html { redirect_to "/patients/#{@charge.patient_id}"}
      format.xml  { head :ok }
    end
  end
  
  def update_charge_status
    logger.debug { "Charge Status => #{params[:charge_status]}" }
    logger.debug { "Charge ID => #{params[:charge_id]}" }

    @charge = Charge.find(params[:charge_id])
    @charge.toggle(:recorded)
    @charge.save

    redirect_to "/reports"
  end
  
  
  def add      
    @procedure_ids = params[:procedure_ids].to_s.split(',')
    @charge_notes = ActiveSupport::JSON.decode(params[:myNotes])
    logger.debug("### ====>  #{@charge_notes}")
    #.split('],[')
    @doctor=cookies[:doctor]
     
    @charge_notes.split("\"], [\"").each_with_index { |v,i| 
         logger.debug {" @charge_notes [0] => #{v[0]} "}
         logger.debug {" @charge_notes [1] => #{v[1]} "}
       }
       
              
    logger.info { "Cookie: Doctor Name=> #{@doctor}" }    
    logger.info { "procedure_ids : #{@procedure_ids.inspect}" }

    #Change patient_been_seen flag to true
    @patient=Patient.find(params[:patient_id])
    @patient.update_attributes :patient_been_seen => true

      @procedure_ids.each_with_index { | i,count | 
        @procedure=Procedure.find(i)
        logger.debug { "" }*3
        logger.debug { "@@@@ => #{@procedure.inspect}" }
#        logger.debug { "@@@@ Notes => #{@charge_notes[i]}" }        
        logger.debug "#{@doctor} Has charged a #{@procedure.procedure_name} => [Code:#{@procedure.procedure_code}]" 
        
        @charge = Charge.new(
              :doctor => @doctor, 
              :fin=>@patient.fin,
              :patient_name=>@patient.patient_name,
              :procedure_name=>@procedure.procedure_name,
              :procedure_code => @procedure.procedure_code, 
              :patient_id => params[:patient_id],
              :is_archived=>false
              #,:note=>@charge_notes.split('], [')[count][1]
              )
              
        @charge.save
        
        }           

                     
#        redirect_to "/patients/#{@charge.patient_id}"
        redirect_to "/patients"
        
  end
end
