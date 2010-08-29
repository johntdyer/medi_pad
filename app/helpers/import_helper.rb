module ImportHelper





  # Checks MRN number to see if we have seen patient before  
  # MRN is a life time ID for FH

    def new_patient?(patient)
      return Patient.find_by_mrn(patient.mrn).nil?
     end

end
