module ApplicationHelper
  
  def SteamIDConvert(from, id)
    if from == 32
      return id + 76561197960265728
    else
      return id - 76561197960265728
    end
  end
  
end
