module ChargesHelper
	def get_info(procedure_code)
		@procedure =  Procedure.all(:conditions => { :procedure_code => procedure_code })
		return @procedure	
	end
end
