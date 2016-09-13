class AddDestroyCountToWelcomes < ActiveRecord::Migration
  def change
    add_column :welcomes, :destroy_count, :integer
  end
end
