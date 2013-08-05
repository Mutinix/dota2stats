class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.string :tag
      t.string :country_code
      t.text :url

      t.timestamps
    end
  end
end
