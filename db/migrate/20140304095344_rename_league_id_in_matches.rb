class RenameLeagueIdInMatches < ActiveRecord::Migration
  def change
    rename_column :matches, :leagueid, :league_id
  end
end
