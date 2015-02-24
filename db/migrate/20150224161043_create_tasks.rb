class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.references :project
      t.string :name
      t.string :description
      t.integer :difficulty_level

      t.timestamps
    end
  end
end
