class ChargesController < ApplicationController
  
  require 'json'


  before_filter :authenticate_user!
  
    
  def index

    if params.has_key?(:time)
       @search=Charge.where('updated_at >= ?', Time.now - date_convert(params[:time])).search(params[:search])
    
    elsif params.has_key?(:search_name)
      @search = Charge.search(:patient_name_contains=>params[:search_name])
    else
      @search = Charge.search(:recorded_equals=>false)

    end
      @charges=@search.all 

    if request.xml_http_request?
      render :partial => "charges", :layout => false
    end
  end


  def show_only_recorded
    logger.info { "" }
    logger.info { "@@@ Log: #{params.inspect}" }

      show_only_recorded = params[:show_only_recorded]

        if show_only_recorded=='true'
            @search=Charge.search(params[:search])
            #.where({:recorded=>false})
        elsif show_only_recorded == 'false'
            logger.info { "FALSE" }
            @search=Charge.search(params[:search])
            #.where({:recorded=>false})
        else
          logger.info { "show_only_recorded not boolean" }
        end
        @reports=@search.all
        #redirect_to '/reports'
  end



  
  # # GET /charges
  # # GET /charges.xml
  # def index
  #   @charges = Charge.all
  # 
  #   respond_to do |format|
  #     format.html # index.html.erb
  #     format.xml  { render :xml => @charges }
  #     format.json  { render :json => @charges }
  #     
  #   end
  # end
  #          
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
        format.json { render :json => @charge }
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
  
  # def update_charge_status
  #     logger.debug { "\n\n\n\tCharge Status => #{params[:charge_status]}" }
  #     logger.debug { "\tCharge ID => #{params[:charge_id]}\n\n\n" }
  # 
  #     @charge = Charge.find(params[:charge_id])
  #     @charge.toggle(:recorded)
  #     @charge.save
  #     respond_to do |format|
  #       format.html {     redirect_to "/reports"}
  #       format.xml  { head :ok }
  #     end
  # 
  #   end             

  def add
    @procedure_array = ActiveSupport::JSON.decode(params[:procedure_ids])#.to_s.split(',')
    @doctor=current_user.username #cookies[:user]
    @patient=Patient.find(params[:patient_id])  
    #logger.info { "Cookie: Doctor Name=> #{@doctor}" }

    @patient.update_attributes :patient_been_seen => true #Change patient_been_seen flag to true

    @procedure_array.each do |i|

      @procedure=Procedure.find(i["charge_id"])

      @charge = Charge.new(
            :doctor => @doctor,
            :fin=>@patient.fin,
            :patient_name=>@patient.patient_name,
            :procedure_name=>@procedure.procedure_name,
            :procedure_code => @procedure.procedure_code,
            :patient_id => @patient.id,
            :option=>i["option_description"],
            :procedure_type=>i["type_description"],
            :locality=>i["location"]
            )
      @charge.save
    end
     redirect_to "/patients/#{params[:patient_id]}"
  end

  private

    def date_convert(v)
     case v.downcase
       when 'hour'
         return 60.minutes.to_i
       when 'day'
         return 24.hours.to_i
       when 'week'
         return 168.hours.to_i
       when 'month'
         return 31.days.to_i
       when 'year'
         return 365.days.to_i
       else 
         return false
       end
   end



end
