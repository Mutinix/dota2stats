class CreatePickBans < ActiveRecord::Migration
  def change
    create_table :pick_bans do |t|
      t.boolean :is_pick
      t.integer :hero_id
      t.integer :team
      t.integer :order
      t.integer :match_id

      t.timestamps
    end
  end
end
