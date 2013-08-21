class ScrimsController < ApplicationController
  
  def create
    params["scrim"]["team1_id"] = current_user.team.id
    
    params["scrim"]["match_time"] = DateTime.parse("#{params['scrim']['date']} #{params['scrim']['time']}")
    params["scrim"].delete("date")
    params["scrim"].delete("time")

    @scrim = Scrim.new(params["scrim"])
    @scrim.save
    if request.xhr?
      render partial: "scrim", locals: {scrim: @scrim}
    else
      redirect_to roster_url
    end
    
  end
  
end
