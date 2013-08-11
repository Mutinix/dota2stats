class AddServerToScrims < ActiveRecord::Migration
  def change
    add_column :scrims, :server, :string
  end
end
