module DoctorsHelper
  
	def get_procedure_name(procedure_code)
		@procedure =  Procedure.find_by_procedure_code(procedure_code)
		return @procedure.procedure_name
	end

end
