class UsersOrganization < ActiveRecord::Base
  belongs_to :user
  belongs_to :organization

  after_save :send_notification_user, :unless => lambda { self.user.role == 'Admin' }

  validates_uniqueness_of :organization_id, :scope => :user_id
  validates :organization, presence: true
  validates :user, presence: true

  def send_notification_user
    UserMailer.notification_user(user.email, user.full_name, organization.name).deliver_now if user.full_name.present?
  end
end
