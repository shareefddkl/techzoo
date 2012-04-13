class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :receiver, :class_name => "User"
  before_create :assign_default_values
  #has_and_belongs_to_many(:users,
   # :join_table => "replies",
   # :foreign_key => "message_id",
   # :association_foreign_key => "user_id")

   
  #Validations
  def assign_default_values
    self.user_status = "sent"
    self.receiver_status = "unread"
  end
end
