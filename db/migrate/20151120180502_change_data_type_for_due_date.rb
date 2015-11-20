class ChangeDataTypeForDueDate < ActiveRecord::Migration
  def change
    remove_column :milestones, :due_date
    add_column :milestones, :due_date, :date
  end
end
