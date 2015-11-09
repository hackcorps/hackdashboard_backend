class CreateMilestones < ActiveRecord::Migration
  def change
    create_table :milestones do |t|
      t.string :name
      t.decimal :percent_complete, precision: 5, scale: 2
      t.timestamp :data_started
      t.integer :due_date
      t.integer :cost
      t.references :organization, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end