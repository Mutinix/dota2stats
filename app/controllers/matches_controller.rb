class MatchesController < ApplicationController
  
  def show
    @match = Match.find(params[:id])
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def index
    @league = League.find_by_id(params[:league_id])
    @league_matches = @league.matches
  end
  
end
