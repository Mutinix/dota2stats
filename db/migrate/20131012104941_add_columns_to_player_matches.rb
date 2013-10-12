class AddColumnsToPlayerMatches < ActiveRecord::Migration
  def change
    add_column :player_matches, :hero_damage, :integer
    add_column :player_matches, :tower_damage, :integer
    add_column :player_matches, :hero_healing, :integer
  end
end
