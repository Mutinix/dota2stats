class ScrimsController < ApplicationController
  
  def create
    params["scrim"]["team1_id"] = current_user.team.id
    @scrim = Scrim.new(params["scrim"])
    @scrim.save
    
    if request.xhr?
      render partial: "scrim", locals: {scrim: @scrim}
    else
      redirect_to roster_url
    end
    
  end
  
end
