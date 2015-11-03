class UsersOrganization < ActiveRecord::Base
  belongs_to :user
  belongs_to :organization
  after_save :send_notification_user
  validates_uniqueness_of :organization_id, :scope => :user_id

  def send_notification_user
    UserMailer.notification_user(user.email, user.full_name, organization.name).deliver_now
  end


end
