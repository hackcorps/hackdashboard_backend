class CreateStandUpSummaries < ActiveRecord::Migration
  def change
    create_table :stand_up_summaries do |t|
      t.datetime :noted_date
      t.string :text
      t.references :organization, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
