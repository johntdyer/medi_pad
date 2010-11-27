module ApplicationHelper
  
  def update_time
       page.replace_html 'time', Time.now.to_s(:db)
       page.visual_effect :highlight, 'time'
     end
     
end
