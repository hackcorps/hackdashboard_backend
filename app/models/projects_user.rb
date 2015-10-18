class ProjectsUser < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  after_save :send_notification_user
  validates_uniqueness_of :project_id, :scope => :user_id
  def send_notification_user
    UserMailer.notification_user(self.user, self.project).deliver_now
  end
end