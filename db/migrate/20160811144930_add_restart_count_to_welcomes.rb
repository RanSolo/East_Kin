class AddRestartCountToWelcomes < ActiveRecord::Migration[5.0]
  def change
    add_column :welcomes, :restart_count, :integer
  end
end
