module OptionsHelper
  
  def get_name(id)
    Procedure.find(id).procedure_name
    
  end
end
