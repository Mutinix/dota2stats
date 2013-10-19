class CreateAbilityUpgrades < ActiveRecord::Migration
  def change
    create_table :ability_upgrades do |t|
      t.integer :ability_id
      t.integer :time
      t.integer :level
      t.integer :player_match_id

      t.timestamps
    end
  end
end
