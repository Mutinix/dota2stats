class AddMatchIdToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :match_id, :bigint
  end
end
