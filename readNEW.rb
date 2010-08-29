require 'rubygems'
require 'hpricot'
require 'rest_client'


	doc = Hpricot(fh)  

	record_count = (doc/"/FHCA/DATA/PATIENTLIST/ROW/N_PATN").length  # This gives me patient count 

	patient_array = Array.new

	p "Patent Records #{record_count}"

  (doc/"/FHCA/DATA/PATIENTLIST/ROW").each_with_index do |item,index|
    record = "record_#{index}"    
    record = {
      :N_PATN=>"#{(item/"/N_PATN").inner_text}",
      :I_UNIT=>"#{(item/"/I_UNIT").inner_text}",
      :I_ROOM=>"#{(item/"/I_ROOM").inner_text}",
      :I_LOCT_PATN=>"#{(item/"/I_LOCT_PATN").inner_text}",
      :N_LOCT=>"#{(item/"/N_LOCT").inner_text}",
      :I_MRI=>"#{(item/"/I_MRI").inner_text}",      #MRI LIFE TIME NUMBER
      :I_ACCN=>"#{(item/"/I_ACCN").inner_text}",    #
      :F_SEX=>"#{(item/"/F_SEX").inner_text}",
      :I_AGE_PATN=>"#{(item/"/I_AGE_PATN").inner_text}",
      :I_ROLE=>"#{(item/"/I_ROLE").inner_text}",
      :F_HIDE_LIST_PATN=>"#{(item/"/F_HIDE_LIST_PATN").inner_text}",
      :I_TYPE_ACCN=>"#{(item/"/I_TYPE_ACCN").inner_text}",
      :D_ADMS_PATN=>"#{(item/"/D_ADMS_PATN").inner_text}",
      :D_DISC_PATN=>"#{(item/"/D_DISC_PATN").inner_text}",
      :Q_LOS=>"#{(item/"/Q_LOS").inner_text}",
      :D_STAR_CLIN_SUMM=>"#{(item/"/D_STAR_CLIN_SUMM").inner_text}",
      :D_END_CLIN_SUMM=>"#{(item/"/D_END_CLIN_SUMM").inner_text}",
      :I_PS_1=>"#{(item/"/I_PS_1").inner_text}",
      :N_PS_1=>"#{(item/"/N_PS_1").inner_text}",
      :R_PS_1=>"#{(item/"/R_PS_1").inner_text}",
      :PHYS_COUNT=>"#{(item/"/PHYS_COUNT").inner_text}"
    }
    #p "--- Record #{index+1}---"
  patient_array << record       # Add hash to array
end

    patient_array.sort_by{|row|row[:N_PS_1]}.each_with_index do |row,index|
			patient_data = {
			  "patient"=>{
					:facility=>row.fetch(:N_LOCT).gsub(/FH /,""),
					:room=>row.fetch(:I_ROOM),
					:bed=>row.fetch(:I_LOCT_PATN),
					:unit=>row.fetch(:I_UNIT),
					:patient_name=>row.fetch(:N_PATN),
					:age=>row.fetch(:I_AGE_PATN).gsub(/Y/,"").sub(/\A0+/, ''),
					:sex=>row.fetch(:F_SEX),
					:admitted=>row.fetch(:D_ADMS_PATN),
					:attending_md=>row.fetch(:N_PS_1)
				}
			}
				RestClient.post 'http://localhost:3000/patients/create',patient_data



			end
