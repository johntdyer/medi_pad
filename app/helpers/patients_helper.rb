module PatientsHelper

  def check_value(i)
    if	i.lstrip.empty?
        i='<font size="3" color="red">n/a</font>'
      end
    return i
  end

  def get_lastname(name)
    return name.split(',', 2)[0]
  end
	
  def been_seen(patient)
    if !patient.charges.empty?
      logger.debug { "Logged Unseen Patient" }
      return image_tag("check_mark.png", :border=>0) 
    end
  end

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
 
 #Get patient FIN from Patient ID
 def get_patient_fin(patient_id)
  @patient = Patient.find(patient_id) 
  return  @patient.fin
  end
end
