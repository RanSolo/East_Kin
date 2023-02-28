class AddDestroyCountToWelcomes < ActiveRecord::Migration[5.0]
  def change
    add_column :welcomes, :destroy_count, :integer
  end
end
