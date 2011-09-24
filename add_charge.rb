  #ID: 1
  Patient.create(:patient_name=>"Albert",:facility=>"EAST",:fin=>"00000001",:mrn=>"00000001",:sex=>"Male",:attending_md=>"Dr A")
  Admission.last.update_attributes(:checkin=>Date.parse('12/31/2010'),:checkout=>Date.parse('01/10/2011'))
  Admission.create(:patient_id=>Patient.last,:checkin=>Date.parse('01/14/2011'))

  #ID: 2
  Patient.create(:patient_name=>"Bob",:facility=>"EAST",:fin=>"00000002",:mrn=>"00000002",:sex=>"Male",:attending_md=>"Dr B")
  Admission.last.update_attributes(:checkin=>Date.parse('12/01/2010'),:checkout=>Date.parse('01/11/2011'))

  #ID: 3
  Patient.create(:patient_name=>"Charlie",:facility=>"EAST",:fin=>"00000003",:mrn=>"00000003",:sex=>"Male",:attending_md=>"Dr C")
  Admission.last.update_attributes(:checkin=>Date.parse('01/11/2011'),:checkout=>Date.parse('01/16/2011'))

  #ID: 4
  Patient.create(:patient_name=>"David",:facility=>"EAST",:fin=>"00000004",:mrn=>"00000004",:sex=>"Male",:attending_md=>"Dr D")
  Admission.last.update_attributes(:checkin=>Date.parse('01/15/2011'))
 
  #ID: 5
  Patient.create(:patient_name=>"Edward",:facility=>"EAST",:fin=>"00000005",:mrn=>"00000005",:sex=>"Male",:attending_md=>"Dr E")
  Admission.last.update_attributes(:checkin=>Date.parse('01/16/2011'))

  # Test Data
  ## 01/10/2010 (1294635600)   =>  Albert, Bob                       (1,2)
  # Admission.where('checkin <= ? AND checkout >= ? OR NULL',Date.parse('01/10/2011'),Date.parse('01/10/2011')).includes(:patient).map(&:patient).uniq.each{|e|p e.patient_name}

  # 01/11/2010 (1294722000)   =>  Bob, Charlie                      (2,3)
  # Admission.where('checkin <= ? AND checkout >= ? OR NULL',Date.parse('01/11/2011'),Date.parse('01/12/2011')).includes(:patient).map(&:patient).uniq.each{|e|p e.patient_name}

  # 01/12/2010 (1294808400)   =>  Bob                               (2)
  # Admission.where('checkin <= ? AND checkout >= ? OR NULL',Date.parse('01/12/2011'),Date.parse('01/13/2011')).includes(:patient).map(&:patient).uniq.each{|e|p e.patient_name}

  # 01/13/2010 (1294894800)   =>  Charlie                           (3)
  # Admission.where('checkin <= ? AND checkout >= ? OR NULL',Date.parse('01/13/2011'),Date.parse('01/13/2011')).includes(:patient).map(&:patient).uniq.each{|e|p e.patient_name}

  ## 01/14/2010 (1294981200)   =>  Albert,Charlie                   (1,3)
  # Admission.where('checkin <= ? AND checkout >= ? OR NULL',Date.parse('01/14/2011'),Date.parse('01/14/2011')).includes(:patient).map(&:patient).uniq.each{|e|p e.patient_name}

  # 01/15/2010 (1295067600)   =>  Albert,Charlie,David              (1,3,4)
  # Admission.where('checkin <= ? AND checkout >= ? OR NULL',Date.parse('01/15/2011'),Date.parse('01/15/2011')).includes(:patient).map(&:patient).uniq.each{|e|p e.patient_name}

  # 01/16/2010 (1295154000)   =>  Albert,Charlie,David,Edward       (1,3,4,5)
  # Admission.scoped(:conditions=>['checkin <= ? AND checkout >= ? OR NULL',Date.parse('01/16/2011'),Date.parse('01/16/2011')]).includes(:patient).map(&:patient).uniq.each{|e|p e.patient_name}

  # 01/17/2010 (1295240400)   =>  Albert,David,Edward               (1,4,5)
  # Admission.where('checkin <= ? AND checkout >= ? OR NULL',Date.parse('01/17/2011'),Date.parse('01/17/2011')).includes(:patient).map(&:patient).uniq.each{|e|p e.patient_name}

  # 01/18/2010 (1295326800)   =>  Albert,David,Edward               (1,4,5)
  # Admission.where('checkin <= ? AND checkout >= ? OR NULL',Date.parse('01/18/2011'),Date.parse('01/18/2011')).includes(:patient).map(&:patient).uniq.each{|e|p e.patient_name}

def add_charges
  
  time = Time.parse('Thu Dec 27 19:24:56 -0500 2010')
  charge_array =[]
  
  charge_array<<Charge.new(:procedure_name=>"Pleurodesis",:doctor=>'jdyer',:procedure_code=>90006,:patient_id=>"3779")
  charge_array<<Charge.new(:procedure_name=>"Pleurodesis1",:doctor=>'jdyer',:procedure_code=>90007,:patient_id=>"3779")
  charge_array<<Charge.new(:procedure_name=>"Pleurodesis2",:doctor=>'jdyer',:procedure_code=>90008,:patient_id=>"3779")
  charge_array<<Charge.new(:procedure_name=>"Pleurodesis3",:doctor=>'jdyer',:procedure_code=>90009,:patient_id=>"3779")
  charge_array<<Charge.new(:procedure_name=>"Pleurodesis4",:doctor=>'jdyer',:procedure_code=>90010,:patient_id=>"3779")
   
  charge_array.each{|e| e.save}
  charge_array.each{|e| e.update_attributes(:created_at=>time,:updated_at=>time)}
end

# def add_patient
#   doctors = ["MASOOD, AHMED","Dr John","Dr. J"]
#   patients = ["JOHNSON, MERVIN", "DYER, JOHN","THURSTON, JACKIE"]
#  p = Patient.create(
#       :facility=>"ORLANDO",
#       :room=>rand(999),
#       :patient_name => patients[rand(patients.size)],
#       :age => rand(99),
#       :sex => "M", 
#       :mrn => rand(9999),
#       :fin =>rand(9999), 
#       :attending_md=> doctors[rand(doctors.size)]
#     )  
#   end  
#

