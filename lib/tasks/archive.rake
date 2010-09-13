# Archive script, takes all recorded records in last 24 hours and achives them

desc 'Archive Records'
  task :archive => :environment do
    records_to_archive=Charge.where('updated_at > ?', Time.zone.now - 1440.minutes).where(:recorded=>true)
    if records_to_archive
      puts "Nothing found"
    else
      records_to_archive.each do |i|
        i.update_attributes(:is_archived=>true)
        puts "Record ID:#{i.id} is_archived=> #{i.is_archived}"
      end
    end
  end
