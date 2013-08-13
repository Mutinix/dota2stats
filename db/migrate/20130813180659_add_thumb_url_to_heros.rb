class AddThumbUrlToHeros < ActiveRecord::Migration
  def change
    add_column :heros, :thumb_url, :text
  end
end
