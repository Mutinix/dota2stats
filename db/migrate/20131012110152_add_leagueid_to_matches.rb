class AddLeagueidToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :leagueid, :integer
  end
end
