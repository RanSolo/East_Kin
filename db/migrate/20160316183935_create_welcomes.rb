class CreateWelcomes < ActiveRecord::Migration
  def change
    create_table :welcomes do |t|
      t.string :bandName
      t.string :headline
      t.string :message
      t.string :logo

      t.timestamps null: false
    end
  end
end
