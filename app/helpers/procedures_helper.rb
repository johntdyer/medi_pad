module ProceduresHelper
  
  #checks if procedure has a nickname, otherwise return procedure name
  def look_for_procecdure_nickname(i)
        if i.procedure_nickname.empty?
          return i.procedure_name
        else
          return i.procedure_nickname
        end
    end
end
