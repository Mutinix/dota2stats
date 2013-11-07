class ChangePrimaryKeyOfMatches < ActiveRecord::Migration
  def change
    remove_column :matches, :id
    add_column :matches, :id, :primary_key
  end
end
