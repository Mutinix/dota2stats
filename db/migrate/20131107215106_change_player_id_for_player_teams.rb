class ChangePlayerIdForPlayerTeams < ActiveRecord::Migration
  def up
    change_column :player_teams, :player_id, :bigint
  end

  def down
    change_column :player_teams, :player_id, :int
  end
end
