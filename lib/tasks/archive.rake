=begin
  Archive Charges Function
    Goal:  Location all patients that meet the following criteria
      -Have NOT been added to the list ( updated_at ) in the last 24 hours  (weekends?)
      -Have NO un-recorded charges associated with them  
      
      If they meet this criteria they are markeds as 'discharged'
      
=end

 desc 'Archive Charges'
  task :archive => :environment do
   ## OLD Charge.where('create < ?', Time.zone.now - 1440.minutes).where(:recorded=>true).each do | old_charge |

   # Find all patients that are older then 24 hours since they were last updated ( e.g. added ont the patient list )
     @old_patients =  Patient.where('created_at < ?', Time.zone.now - 1440.minutes).where(:discharged=>false)

        is_dischargable=false

        @old_patients.each do | patient |  # Check a patient
          patient.charges.each do | charge |         #check each charge

            if charge.recorded
              is_dischargable=true
            else
              is_dischargable=false
            end
              charge.patient.update_attributes(:discharged=>true) if is_dischargable
                # puts "@ Archive:\t
                #               Name:\t#{charge.patient.patient_name}\t
                #               Patient ID:\t#{charge.patient.id}\t
                #               Patient FIN:\t#{charge.patient.fin}\t
                #               Procedure\t#{charge.procedure_name}\t
                #               ChargeID:\t#{charge.id}\t"  
          end
        end
  end
