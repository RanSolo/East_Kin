class AddRestartCountToWelcomes < ActiveRecord::Migration
  def change
    add_column :welcomes, :restart_count, :integer
  end
end
