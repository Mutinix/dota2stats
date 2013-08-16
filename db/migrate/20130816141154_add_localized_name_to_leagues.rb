class AddLocalizedNameToLeagues < ActiveRecord::Migration
  def change
    add_column :leagues, :localized_name, :string
  end
end
