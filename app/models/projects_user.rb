class ProjectsUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  after_create :send_invite

   def send_invite
   # UserMailer.invitation('sofia.nabivanec@gmail.com', 'zzzzzzz').deliver_now
  end
end
