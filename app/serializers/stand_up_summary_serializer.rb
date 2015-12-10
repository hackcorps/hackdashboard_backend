class StandUpSummarySerializer < ActiveModel::Serializer
  attributes :id, :text, :noted_date
  has_many :stand_ups

  def noted_date
    object.noted_date.strftime("%A %B %e, %Y")
  end

end
