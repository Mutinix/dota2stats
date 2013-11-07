class ChangePrimaryKeyTypeForMatches < ActiveRecord::Migration
  def change
    change_column :matches, :id, :integer, :limit => 8
  end
end
