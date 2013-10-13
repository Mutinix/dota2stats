class AddLeaverStatusToPlayerMatches < ActiveRecord::Migration
  def change
    add_column :player_matches, :leaver_status, :integer
  end
end
