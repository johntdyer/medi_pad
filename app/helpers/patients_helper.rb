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
			return	image_tag("check_mark.png", :border=>0)
			logger.debug { "Unseen Patient" }
		end
	end
end
