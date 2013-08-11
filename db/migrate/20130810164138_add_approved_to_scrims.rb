class AddApprovedToScrims < ActiveRecord::Migration
  def change
    add_column :scrims, :approved, :boolean
  end
end
