# Archive script, takes all recorded records in last 24 hours and achives them

desc 'Archive Records'
  task :archive_patients => :environment do  
    patients_to_archive=Patient.where('date_last_added < ?', Time.zone.now - 1440.minutes).where(:patient_been_seen=>true)
      if patients_to_archive.nil?
        puts "Nothing found"
      else
        patients_to_archive.each do |i|
          #i.update_attributes(:is_archived=>true)
          puts "Record ID:#{i.id} is_archived=> #{i.discharged}"
        end
      end
  end
