class CreateScrims < ActiveRecord::Migration
  def change
    create_table :scrims do |t|
      t.integer :team1_id
      t.integer :team2_id
      t.datetime :match_time

      t.timestamps
    end
  end
end
