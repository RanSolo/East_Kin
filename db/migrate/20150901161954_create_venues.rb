class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string   :name
      t.string   :link
      t.string   :link2
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.string   :about
      t.string   :location
      t.integer  :phone
      t.timestamps null: false
    end
  end
end
