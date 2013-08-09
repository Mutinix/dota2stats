class TeamsController < ApplicationController
  
  before_filter :authenticate_user!
  
  def show
    @team = current_user.team
    @scrims = @team.challenges
  end
  
end
