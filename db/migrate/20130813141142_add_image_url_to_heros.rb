class AddImageUrlToHeros < ActiveRecord::Migration
  def change
    add_column :heros, :image_url, :text
  end
end
