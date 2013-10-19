class CreateAdditionalUnits < ActiveRecord::Migration
  def change
    create_table :additional_units do |t|
      t.string :unitname
      t.integer :item_0
      t.integer :item_1
      t.integer :item_2
      t.integer :item_3
      t.integer :item_4
      t.integer :item_5
      t.integer :player_match_id

      t.timestamps
    end
  end
end
