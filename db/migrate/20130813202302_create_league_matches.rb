class CreateLeagueMatches < ActiveRecord::Migration
  def change
    create_table :league_matches do |t|
      t.integer :league_id
      t.integer :match_id

      t.timestamps
    end
  end
end
