module ReportsHelper
  
  def charge_recorded?(recorded)
     if !recorded
       return "no"
     else
       return  image_tag("check_mark.png", :border=>0) 
     end
   end
   
end
