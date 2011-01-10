class AdminController < ApplicationController
  before_filter :authenticate_user!

      def index
        @users = User.all   
      end
      
      def upload
        uploaded_file = params[:xml_file]
        data = uploaded_file.read if uploaded_file.respond_to? :read
        if request.post? and data
          case params[:commit]
            when "Import" 
              parse_with_hpricot( data )
              logger.info "Successfully imported."
              #flash[:notice] = "Successfully imported."
              redirect_to :action => 'index'
            else
              logger.error "Import Error"
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
        
        logger.info "@@@ LOG: #{record_count} records to import"

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
                    :attending_md=>(item/"/N_PS_1").inner_text,
                    :date_last_added=>Time.now(),
                    :patient_been_seen=>false,
                    :discharged=>false
                  )
          if @patient.save

            #Patient has never been admitted, create an admission record
            Admission.create(:patient_id=>@patient.id,:checkin=>Date.today)
            logger.debug "\n=====>\t@@@ Log: Patient #{(item/"/N_PATN").inner_text} was succesfully imported <=====\n"
            success_messages << "#{(item/"/N_PATN").inner_text} was succesfully imported"

          else 
            patient = Patient.find_by_fin((item/"/I_ACCN").inner_text)
            patient.update_attributes(:date_last_added=>Time.now())

            Admission.create(
                      :patient_id=>patient.id,
                      :checkin=>Date.today
                    ) unless Admission.find_last_by_patient_id(patient.id).checkout.nil?

            undischarge_patient(patient)
            patient.save
            logger.info "@@@ Log: Patient #{(item/"/N_PATN").inner_text} already Exists"
            failed_messages << "#{(item/"/N_PATN").inner_text} already Exists"
          end
        end
        flash[:notice] = success_messages
        flash[:error] = failed_messages
      end

      
      #validates user
      def validate
          @user = User.find(params[:userID])
          logger.debug "@@@ Validating #{@user.username}"
          @user.toggle(:validated)
          @user.save
          redirect_to :action => 'index'
       end


       # Send an invite 
       def invite
         User.new(:email=>params[:email], :first_name=>params[:first_name], :last_name=>params[:last_name]).invite!    
         respond_to do |format|
          format.html { redirect_to('/home', :notice => 'Invtes was sent') }
         end
      end

 private
 
    def undischarge_patient(patient)
      if patient.discharged 
        logger.info("\n\n\n \t\t #{patient.patient_name} was discharged, re-admitting her \n\n\n")
        patient.update_attributes(:discharged=>false,:patient_been_seen=>false) 
      end 
    end

end