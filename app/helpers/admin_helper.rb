module AdminHelper
  
  # Checks MRN number to see if we have seen patient before  
  # MRN is a life time ID for FH

    def new_patient?(patient)
      return Patient.find_by_mrn(patient.mrn).nil?
     end
  
  def enabled_or_disabled(user)
     html = Array.new
      html<<"<td><a href=\"#\" class=\"admin_#{user.is_admin}_button\" id=\"admin_#{user.id}\" style=\"color:#{user.is_admin ? "green" : "red"};\">#{user.is_admin ? "Enabled" : "Disabled"}</a></td>"
      html<<"<td><a href=\"#\" class=\"billing_#{user.is_billing}_button\" id=\"billing_#{user.id}\" style=\"color:#{user.is_billing ? "green" : "red"};\">#{user.is_billing ? "Enabled" : "Disabled"}</a></td>"
      html<<"<td><a href=\"#\" class=\"doctor_#{user.is_doctor}_button\" id=\"doctor_#{user.id}\" style=\"color:#{user.is_doctor ? "green" : "red"};\">#{user.is_doctor ? "Enabled" : "Disabled"}</a></td>"
     return html
  end

 
  
end
