class AdminController < ApplicationController
      def index
        
      end


      def upload
        uploaded_file = params[:xml_file]
        data = uploaded_file.read if uploaded_file.respond_to? :read

        if request.post? and data
          case params[:commit]
            when "Import" : parse_with_hpricot( data )
              logger.info { "Successfully imported." }
  #            flash[:notice] = "Successfully imported."
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

        require 'rubygems'
        require 'hpricot'
        success_messages = Array.new
        failed_messages = Array.new


        record_count = (Hpricot(data)/"/FHCA/DATA/PATIENTLIST/ROW/N_PATN").length  # This gives me patient count 
        logger.info { "@@@ LOG: #{record_count} records to import" }

        (Hpricot(data)/"/FHCA/DATA/PATIENTLIST/ROW").each_with_index do |item,index|
          record = "record_#{index}"
            @patient = Patient.new(
                    :facility=>(item/"/N_LOCT").inner_text.gsub(/FH /,""),
                    :room=>(item/"/I_ROOM").inner_text,
                    :bed=>(item/"/I_LOCT_PATN").inner_text,
                    :fin=>(item/"/I_ACCN").inner_text,
                    :mrn=>(item/"/I_MRI").inner_text,
                    :unit=>(item/"/I_UNIT").inner_text,
                    :patient_name=>(item/"/N_PATN").inner_text,
                    :age=>(item/"/I_AGE_PATN").inner_text.gsub(/Y/,"").sub(/\A0+/, ''),
                    :sex=>(item/"/F_SEX").inner_text,
                    :admitted=>(item/"/D_ADMS_PATN").inner_text,
                    :attending_md=>(item/"/N_PS_1").inner_text
                  )
          if @patient.save
            logger.info {"@@@ Log: Patient #{(item/"/N_PATN").inner_text} was succesfully imported"}
            success_messages << "#{(item/"/N_PATN").inner_text} was succesfully imported"
          else 
            logger.info {"@@@ Log: Patient #{(item/"/N_PATN").inner_text} already Exists" }
            failed_messages << "#{(item/"/N_PATN").inner_text} already Exists"
          end
        end
        flash[:notice] = success_messages
        flash[:error] = failed_messages
      end
  
  
end
