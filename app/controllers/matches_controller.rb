class MatchesController < ApplicationController
  
  def show
    @match = Match.find(params[:id])
  end
  
  def index
    @league = League.find_by_id(params[:league_id])
    @league_matches = @league.matches
  end
  
end
