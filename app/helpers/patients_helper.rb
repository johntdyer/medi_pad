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
  
    def capitalize_each(v)
      return_array=[]
      v.split(" ").each{|e|return_array << e.capitalize + ' '}
      return_array.to_s.strip
    
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
        return return_array
     end 
 end

  def get_day(params = {})
    params = {
      :time=>Time.now,
      :value=>0,
      :format=>"day"
      }.merge(params)
      
        time = params[:time]+params[:value].days
        case params[:format]
          when "day"
            return time.strftime("%a")
          when "full"
            return time.strftime("%A, %b %d")
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


  #This method helps us keep the current location in the querystring for navigation
  def get_selected_location
    # Does the URL have a location parameter?
    if request.request_uri.include?("location")
      begin
        location_url = request.request_uri.split("?")[1].split("&")[0]
      rescue Exception=>e 
        # Guard if there is no location in the URL
        return ""
      end
     return "#{location_url}&"
    end
  end

  # Checks each patients charges, only displaying a count of todays charges
  def count_todays_charges(opts={})
    opts = {
      :time_stamp=>Time.now.midnight,
      }.merge(opts)

          # charges = Charge.where({
          #        :created_at.gte=>opts[:time_stamp].midnight,
          #        :created_at.lte=>opts[:time_stamp].midnight+1.day,
          #        :patient_id.eq=>opts[:patient].id
          #       })

    charge_count = 0

    opts[:patient].charges.each{|charge|
      if charge.created_at>=opts[:time_stamp].midnight
        charge_count = charge_count+1
        logger.debug { "\t#{charge.inspect}\n\n" }
      end
    }
    
    if charge_count == 0
      return "<font color=\"red\">0</font>"
    else
      return "<font color=\"green\">#{charge_count}</font>"
    end
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
     
  def get_unrecorded_charges(opts={})
    unrecorded_charges =[]
    
    opts = {
      :time_stamp=>session[:selected_time]
      }.merge(opts)

      opts[:charges].each do | charge | 
        if !charge.recorded   
          #logger.debug("Live Charge #{charge.procedure_name}")
          if charge.created_at >= session[:selected_time]
            unrecorded_charges<<charge                     
          end
        end
      end
      return unrecorded_charges
  end

end