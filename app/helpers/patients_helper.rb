module PatientsHelper

  def check_value(i)  
      html = '' 
     
    if i
      if  i.lstrip.empty? 
        return "<font size=\"3\" color=\"red\">n/a</font>"
      else
        html<<i
      end    
      return html
    end
  end

  
  def get_lastname(name)
    return name.split(',', 2)[0]
  end

  # Patient been seen in last 24 hours?

	def been_seen(patient)
     been_seen = false;
     time_now = Time.now
     if !patient.charges.empty?  
       patient.charges.each { | charge | been_seen = true unless charge.created_at < Time.now - 1440.minutes }
     end
     return been_seen
       # true        
       #         # image_tag("check_mark.png", :border=>0)
       #      end
   end
   
  #  
  # def been_seen(patient)
  #   if !patient.charges.empty?
  #     logger.debug { "Logged Unseen Patient" }
  #     return image_tag("check_mark.png", :border=>0) 
  #   end
  # end 

  #Returns a unique array of facilities in our database, used for tabs on patients/index.html.erb
  def get_list_of_facilities()
      @facilities = []
       @list = Patient.all(:select=>"DISTINCT facility")
       
       @list.each do | i |
         @facilities << i.facility
       end
      
      return @facilities
  end

 
 #Returns the current search object, also capilalizes first letter of each letter in word
 def fix_location_name(i)
   if i.facility.nil?
      return i.facility
      else
         return_array = []
         i.facility.split.each {|w| return_array << w.capitalize + ' '}
        return  return_array
     end 
 end


def location_name(i)
  case i
    when 'Winter park' 
      "WPK"
    when 'Altamonte'
      "Alt"
    when 'East orlando' 
      "East"
    when 'Orlando' 
      "Orl"
    when 'Medical plaz' 
      "Plaza"
    else
      return i
   end
end
 
 #Get patient FIN from Patient ID
 def get_patient_fin(patient_id)
  @patient = Patient.find(patient_id) 
  return  @patient.fin
  end
  
  #find record ID for procedure code
  def lookup_procedure_code(p)
    @id =Procedure.find_by_procedure_code(p)
    return @id
  end             
  
  # We dont want to show charges associated with a patient that have been archived 
  # def get_unarchived_charges(charges)
  #   current_charges =[]
  #     charges.each do | charge | 
  #       if !charge.is_archived   
  #         logger.debug("Live Charge #{charge.procedure_name}")
  #         current_charges<<charge
  #       end
  #     end
  #     return current_charges
  # end  
     
  def get_unrecorded_charges(charges)
    unrecorded_charges =[]
      charges.each do | charge | 
        if !charge.recorded   
          logger.debug("Live Charge #{charge.procedure_name}")
          unrecorded_charges<<charge
        end
      end
      return unrecorded_charges
  end
  
  
end

