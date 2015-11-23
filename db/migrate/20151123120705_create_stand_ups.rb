class CreateStandUps < ActiveRecord::Migration
  def change
    create_table :stand_ups do |t|
      t.string :update_text
      t.date :noted_at
      t.references :user, index: true, foreign_key: true
      t.references :milestone, index: true, foreign_key: true
      t.references :stand_up_summary, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
