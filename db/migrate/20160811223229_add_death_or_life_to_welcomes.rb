class AddDeathOrLifeToWelcomes < ActiveRecord::Migration[5.0]
  def change
    add_column :welcomes, :deathOrLife, :boolean
  end
end
