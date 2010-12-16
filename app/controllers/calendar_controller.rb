class CalendarController < ApplicationController

  before_filter :authenticate_user!

  def index

      if params.has_key?(:date)
         # Take the calendar date, rollback to 12am
         time_stamp = Time.parse(params[:date]).midnight
       else
         # Else get today patients
         time_stamp = Time.now.midnight
       end

       records = Array.new
          
          if params.has_key?(:id)
            search_results = Patient.search(:id_equals=>params[:id])
          else
            @current_list  =  Patient.where({
                :created_at.lt =>  time_stamp+1.day, 
                :created_at.gt => time_stamp
              })
          end

          @current_list.each do | record |
                     tmpVar = [
                              "<img src=\"../images/examples_support/details_open.png\">",
                              record[:patient_name],
                              record[:date_last_added].strftime("%m/%d/%Y"),
                              record[:attending_md],
                              record[:facility].capitalize,
                              record[:id]
                             ]
                            # This get the charges for this patient
                            # - Note this slows the query down a bit, perhaps we can find a more
                            #   efficient way of going about this....?
                           
                            tmpVar.push(get_todays_charges(record[:id],time_stamp.to_s).count)

                 records.push(tmpVar)
               end

               respond_to do |format|
                 format.html 
                 #format.xml  { render :xml => @patients }
                 format.json  {
                   render :json => {
                     :date=>time_stamp.to_s,
                     :iTotalRecords=>@current_list.count,
                     :iTotalDisplayRecords=>@current_list.count,
                     :aaData => records
                   }.to_json
                 }
          end
  end

  # Get charges for a patient, for a given day, return JSON
  def show
    charges = Array.new

    # Patient FIN Number for sub-menu
    patient_fin = Patient.find(params[:patientID])[:fin]
    
    # Find all charges for today, and create a hash
    get_todays_charges(params[:patientID],params[:selectedDate]).each do |charge|
        tmpVar = {
            :id=>charge[:id],
            :procedure_name=>charge[:procedure_name],
            :procedure_type=>charge[:procedure_type],
            :option=>charge[:option],
            :locality=>charge[:locality],
            :charging_doctor=>charge[:doctor],
            :been_recorded=>charge[:recorded]
          }
          charges.push(tmpVar)
    end

    respond_to do |format|
      format.xml  { render :xml => @patients }
      format.json  { 
        render :json => {:patient_fin=>patient_fin,:totalCharges => charges.count,:searchDate=>params[:selectedDate],:aaData => charges }.to_json 
      }
    end
  end

  private 

    def get_todays_charges(patient_id,date)
      Charge.where({
          :created_at.lt => Time.parse(date).midnight+1.day, 
          :created_at.gt => Time.parse(date).midnight,
          :patient_id.eq=>patient_id
          })
    end

end