class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer  :venue_id
      t.datetime :start_time
      t.datetime :end_time
      t.string :description
      t.string :title
      t.string :link, nil
      t.string :link2, nil
      t.string :link3, nil
      t.timestamps null: true
    end
  end
end
