class AddLobbyTypeToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :lobby_type, :integer
  end
end
