class CreateJobs < ActiveRecord::Migration[5.0]
  def change
    create_table :jobs do |t|
      t.boolean :status
      t.integer :dependant

      t.timestamps
    end
  end
end
