def add_patient
 p = Patient.create(
      :facility=>"ORLANDO",
      :room=>rand(999),
      :patient_name => "JOHNSON, MERVIN", 
      :age => 63, 
      :sex => "M", 
      :mrn => "000979748", 
      :fin =>"0081170987", 
      :attending_md=> "MASOOD, AHMED"
    )
  p.save
#  Patient.last.update_attributes(:)
Patient.all.each{|e| e.update_attributes(:created_at=>DateTime.now-1.day,:date_last_added=>DateTime.now-1.day,:updated_at=>DateTime.now-1.day)}
Patient.all.each{|e|c = Charge.new(:procedure_name=>"Pleurodesis",:doctor=>'jdyer',:procedure_code=>90006,:patient_id=>e.id); c.save}
Charge.all.each{|c| c.update_attributes(:created_at=>DateTime.now-1.day,:updated_at=>DateTime.now-1.day)}
end

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