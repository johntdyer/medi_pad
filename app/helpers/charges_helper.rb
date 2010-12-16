module ChargesHelper
	def get_info(procedure_code)
		@procedure =  Procedure.all(:conditions => { :procedure_code => procedure_code })
		return @procedure
	end
	
	def lookup_procedure_name(procedure_code)
	  @procedure =  Procedure.all(:conditions => { :procedure_code => procedure_code })
	end

  def charge_recorded?(recorded)
     if !recorded
       return false
     else
       return true
       image_tag("check_mark.png", :border=>0) 
     end
   end

	
	
end
