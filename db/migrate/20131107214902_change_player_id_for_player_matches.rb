class ChangePlayerIdForPlayerMatches < ActiveRecord::Migration
  def up
    change_column :player_matches, :player_id, :bigint
  end

  def down
    change_column :player_matches, :player_id, :int
  end
end
