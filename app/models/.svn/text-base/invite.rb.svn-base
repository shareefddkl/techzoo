class Invite < ActiveRecord::Base
   validates :emails,    :presence => true,      :length => { :maximum => 90, :minimum => 6 }
  after_create :send_email

  def send_email
    UserMailer.send_invitation(self).deliver
#    self.user.update_attribute(:credits, (self.user.credits.to_i+DEAL_SHARE_CREDITS)) if self.user and UserSharedDeal.where(["user_id = ? AND email = ?", self.user_id, self.email]).count
  end
end
