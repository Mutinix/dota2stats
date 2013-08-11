class TeamsController < ApplicationController
  
  before_filter :authenticate_user!
  
  def show
    @team = current_user.team
    @challenges = @team.challenges
  end
  
end
