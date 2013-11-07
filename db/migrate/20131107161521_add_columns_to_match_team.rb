class AddColumnsToMatchTeam < ActiveRecord::Migration
  def change
    add_column :match_teams, :radiant_team_complete, :integer
    add_column :match_teams, :dire_team_complete, :integer
    
    add_column :match_teams, :radiant_guild_id, :integer
    add_column :match_teams, :dire_guild_id, :integer
    
    add_column :match_teams, :radiant_guild_name, :integer
    add_column :match_teams, :dire_guild_name, :integer
    
    add_column :match_teams, :radiant_guild_logo, :string
    add_column :match_teams, :dire_guild_logo, :string
  end
end
