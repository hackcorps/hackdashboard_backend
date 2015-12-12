class MilestoneSerializer < ActiveModel::Serializer
  attributes :id, :name, :data_started, :due_date, :organization_id, :percent_complete, :cost
end