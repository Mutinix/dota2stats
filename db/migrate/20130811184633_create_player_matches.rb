class CreatePlayerMatches < ActiveRecord::Migration
  def change
    create_table :player_matches do |t|
      t.integer :match_id
      t.integer :player_id
      t.integer :player_slot
      t.integer :hero_id
      t.integer :item_0
      t.integer :item_1
      t.integer :item_2
      t.integer :item_3
      t.integer :item_4
      t.integer :item_5
      t.integer :kills
      t.integer :deaths
      t.integer :assists
      t.integer :gold
      t.integer :last_hits
      t.integer :denies
      t.integer :gold_per_min
      t.integer :xp_per_min
      t.integer :gold_spent
      t.integer :level

      t.timestamps
    end
  end
end
