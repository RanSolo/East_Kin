class AddLabelToJobs < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :label, :string
  end
end
