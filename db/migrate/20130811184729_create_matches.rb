class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.boolean :radiant_win
      t.integer :duration
      t.integer :game_mode

      t.timestamps
    end
  end
end
