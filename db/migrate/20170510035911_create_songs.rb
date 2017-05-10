class CreateSongs < ActiveRecord::Migration[5.0]
  def change
    create_table :songs do |t|
      t.text :lyric
      t.string :title
      t.string :writers
      t.text :copyright
      t.boolean :active
      t.string :youtube
      t.string :facebook
      t.string :soundcloud
    end
  end
end
