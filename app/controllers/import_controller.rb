class ImportController < ApplicationController
  
    def index
      @imports = Import.all(:limit => 10)
    end

    
    def upload
      uploaded_file = params[:xml_file]
      data = uploaded_file.read if uploaded_file.respond_to? :read

      if request.post? and data
        case params[:commit]
          when "Parse with Hpricot" : parse_with_hpricot( data )
            logger.info { "Successfully imported." }
            flash[:notice] = "Successfully imported."
            redirect_to :action => 'index'            
          else 
            logger.info { "Import Error"}
            flash[:notice] = "Import Error"
            redirect_to :action => 'index'
            
        end
      else
        redirect_to :action => 'index'
      end
    end

    def parse_with_hpricot(data)
      record_count = (Hpricot(data)/"/FHCA/DATA/PATIENTLIST/ROW/N_PATN").length  # This gives me patient count 
      logger.info { "@@@ LOG: #{record_count} records to import" }

      (Hpricot(data)/"/FHCA/DATA/PATIENTLIST/ROW").each_with_index do |item,index|
        record = "record_#{index}"
          @patient = Patient.new
            @patient.facility=(item/"/N_LOCT").inner_text.gsub(/FH /,""),
            @patient.room=(item/"/I_ROOM").inner_text,
            @patient.bed=(item/"/I_LOCT_PATN").inner_text,
            @patient.unit=(item/"/I_UNIT").inner_text,            
            @patient.patient_name=(item/"/N_PATN").inner_text,
            @patient.age=(item/"/I_AGE_PATN").inner_text.gsub(/Y/,"").sub(/\A0+/, ''),
            @patient.sex=(item/"/F_SEX").inner_text,
            @patient.admitted=(item/"/D_ADMS_PATN").inner_text,
            @patient.attending_md=(item/"/I_PS_1").inner_text
          if @patient.save ( logger.info { "@@@ Log: Patient #{index} of #{record_count} [ #{(item/"/I_UNIT").inner_text}] Imported" } ) 
            else (logger.info { "@@@ Log: Patient #{index} of #{record_count} [ #{(item/"/I_UNIT").inner_text}] FAILED" })
          end
        end
      end
end