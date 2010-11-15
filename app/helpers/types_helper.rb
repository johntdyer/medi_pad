module TypesHelper
  

  def check_location(i,location)
    return true if i.location.downcase == location if i.location
    return false
  end
end
