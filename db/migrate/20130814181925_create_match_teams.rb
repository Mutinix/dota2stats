class CreateMatchTeams < ActiveRecord::Migration
  def change
    create_table :match_teams do |t|
      t.integer :match_id
      t.integer :radiant_team_id
      t.string :radiant_logo
      t.integer :dire_team_id
      t.string :dire_logo

      t.timestamps
    end
  end
end
