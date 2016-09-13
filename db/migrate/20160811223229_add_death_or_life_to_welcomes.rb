class AddDeathOrLifeToWelcomes < ActiveRecord::Migration
  def change
    add_column :welcomes, :deathOrLife, :boolean
  end
end
