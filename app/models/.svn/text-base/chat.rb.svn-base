class Chat < ActiveRecord::Base
  belongs_to :sender, :class_name => "User"
  belongs_to :reciever, :class_name => "User"

  validates :sender_id, :reciever_id, :text, :presence => true

  scope :unread, :conditions => {:read_at => nil}
  scope :read, :conditions => "chats.read_at IS NOT NULL"
  scope :since, lambda{|date_time| {:conditions => ["created_at >= ?", date_time.to_time.in_time_zone.to_s(:db)]} }

  def read_now
    self.update_attributes(:read_at => Time.now)
  end

  def json_data
    { :text => self.text, :senderId => self.sender_id, :recieverId => self.reciever_id, :senderName => self.sender.display_name, :recieverId => self.reciever.id, :recieverName => self.reciever.display_name}
  end
end