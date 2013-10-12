class AddColumnsToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :tower_status_radiant, :integer
    add_column :matches, :tower_status_dire, :integer
    add_column :matches, :barracks_status_radiant, :integer
    add_column :matches, :barracks_status_dire, :integer
    add_column :matches, :cluster, :integer
    add_column :matches, :first_blood_time, :integer
    add_column :matches, :human_players, :integer
    add_column :matches, :positive_votes, :integer
    add_column :matches, :negative_votes, :integer
  end
end
