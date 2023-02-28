class CreateWelcomes < ActiveRecord::Migration[5.0]
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
