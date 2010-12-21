module HomeHelper


  def supported_browser
    return true unless browser_type=='IE'
  end
   
  def alert_user
    if !supported_browser
       "alert('We do not support Internet Explorer, please use Firefox / Chrome, or any other real browser.. Even an imaginary browser is better then Internet Explorer, I mean come on, for real :)');"
    end
  end
  
  private
    
  def browser_type
    if request.user_agent=~/Macintosh/
      $browser = "osx"
    elsif request.user_agent=~/iPhone/
      $browser = "iPhone"
    elsif request.user_agent=~/Android/
      $browser = "android"   
    elsif request.user_agent=~/MSIE/
      $browser = "IE"
    else
      $browser = "other"
    end
  end
end
