module UsersHelper
  
	def get_procedure_name(procedure_code)
		@procedure =  Procedure.find_by_procedure_code(procedure_code)
		return @procedure.procedure_name
	end


  def get_favorites_array(current_user)

    return RbYAML.load(current_user.favorites)

  end
end
