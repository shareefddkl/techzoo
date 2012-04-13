 require 'digest/sha2'
class User < ActiveRecord::Base
  #has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  # :default_url => "/images/default_avatar.gif",
  #:url =>  "/uploaded_files/avatar/:id/:style/:basename.:extension",
  #:path=> ":rails_root/public/uploaded_files/avatar/:id/:style/:basename.:extension",


  #  validates_attachment_presence :avatar
  #validates_attachment_content_type :avatar
  #validates_attachment_size :avatar
  has_one :student, :dependent => :destroy
  has_one :mentor, :dependent => :destroy
  has_many :courses, :dependent => :destroy
  has_many :received_messages, :class_name => "Message", :foreign_key => :receiver_id, :dependent => :destroy, :order => "created_at DESC"
  has_many :sent_messages, :class_name => "Message", :foreign_key => :user_id, :dependent => :destroy, :order => "created_at DESC"
  has_attached_file :avatar, :styles => {:small => "50*50>", :thumb => "50*50>"}, :default_url => "/images/avatar.png"
  has_many :feedbacks, :dependent => :destroy
  # has_and_belongs_to_many(:messages,
  #  :join_table => "replies",
  # :foreign_key => "user_id",
  #:association_foreign_key => "message_id")
 has_many :ads, :dependent => :destroy
  has_many :discussions, :dependent => :destroy
  has_many :comments, :class_name => "CommentsVideo", :foreign_key => :user_id, :dependent => :destroy
  #  validates :email, :presence => true, :uniqueness => true
  # --------- chats --------------
  has_many :recieved_chats, :class_name => "Chat", :foreign_key => :reciever_id
  has_many :sent_chats, :class_name => "Chat", :foreign_key => :sender_id
  has_many :imported_contacts, :dependent => :destroy

  def chats
    self.last_login ? [self.recieved_chats.since(self.last_login).read + self.sent_chats.since(self.last_login).read].flatten.sort{|a, b| a.created_at <=> b.created_at} : []
  end
  # ------------------------------

  validates :email,
    :presence => true,
    :uniqueness => true,  :length => { :maximum => 90, :minimum => 6 },
    :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
  validates :password, :presence => true, :confirmation => true, :if => :password_required?
  validates :password_confirmation, :presence => true, :if => :password_required?
  validates :password,  :length => { :maximum => 90, :minimum => 6 }, :if => :password_required?
  validates :user_type, :inclusion => { :in => USER_TYPES }
  validate :password_must_be_present
  #validate :i_agree , :presence => true
 #validates_acceptance_of :i_agree, :message => "must be agree with terms"
 #validates :i_agree, :inclusion => {:in => [true, false]}
 validates_acceptance_of :terms_of_service, :message => "must be agree with terms"




  attr_accessor :password_confirmation
  attr_reader :password

  before_create :assign_default_values
  delegate :first_name, :middle_name, :last_name,:education_type,:to => :mentor, :prefix => true, :allow_nil => true
  delegate :first_name, :middle_name, :last_name,:education_type, :to => :student, :prefix => true, :allow_nil => true

  define_index do
    indexes student(:first_name), :as => :student_first_name, :sortable => true
    indexes student(:last_name), :as => :student_last_name, :sortable => true
    indexes student(:middle_name), :as => :student_middle_name, :sortable => true
    indexes student(:education_type), :as => :student_education_type, :sortable => true
    indexes mentor(:first_name), :as => :mentor_first_name, :sortable => true
    indexes mentor(:last_name), :as => :mentor_last_name, :sortable => true
    indexes mentor(:middle_name), :as => :mentor_middle_name, :sortable => true
    indexes mentor(:education_type), :as => :mentor_education_type, :sortable => true
    indexes user_type
    indexes account_id, :sortable => true
  end
  

  def contacted_user_ids
    User.find_by_sql("select DISTINCT(messages_users.to_id) AS id from messages_users where message_id IN (select id from messages where user_id = #{self.id}) UNION select sent_to from sent_gifts where user_id = #{self.id}").map{|u| u.id}
  end
  def is_online?
    return self.online_status == 'online'
  end

  class << self
    def authenticate(email, password)
      if user = find_by_email(email)
        if user.status == 'active' || 'pending' and user.hashed_password == encrypt_password(password, user.salt)
          user
        end
      end
    end

    def encrypt_password(password, salt)
      Digest::SHA2.hexdigest(password + "wibble" + salt)
    end
  end

  # 'password' is a virtual attribute
  def password=(password)
    @password = password
    if password.present?
      generate_salt
      self.hashed_password = self.class.encrypt_password(password, salt)
    end
  end

  def generate_password_reset_code
    self.reset_password_code = Digest::SHA2.hexdigest(Time.now.to_s)
    save
    UserMailer.password_reset(self).deliver
  end

  def activate
    self.activation_code = nil
    self.activated_at = Time.now
    self.status = 'active'
    save!
    UserMailer.activation_notification(self).deliver
  end

  def display_name
    if self.mentor
      self.mentor.first_name + "  " +self.mentor.middle_name + "  " + self.mentor.last_name
    elsif self.student
      self.student.first_name+ "  "+self.student.middle_name+"  "+self.student.last_name
    end
  end

  def online_status
    if self.last_accessed_at and self.is_online
      self.last_accessed_at < 5.minutes.ago ? "offline" : "online"
    else
      return "offline"
    end
  end

  def json_data
    { :name => self.display_name.to_s,
      :id => self.id,
      :status => self.online_status,
      :email => self.email
    }
  end

  def read_chats
    chats = self.recieved_chats.unread
    chats.each{|c| c.read_now}
    chats
  end


  

  def create_account_id
    if self.account_id.to_s.blank?
      self.update_attribute(:account_id, get_account_id)
    end
  end

  private

  def password_must_be_present
    errors.add(:password, "Missing password") unless hashed_password.present?
  end

  def generate_salt
    self.salt = self.object_id.to_s + rand.to_s
  end


  def send_password_reset
    generate_token(:password_reset_token)
    self.last_password_reseted_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def assign_default_values
    self.status = 'pending'
    self.activation_code = Digest::SHA2.hexdigest(self.email+Time.now.to_s)
    #    self.account_id = get_account_id
    self.email_encrypted = Digest::SHA2.hexdigest(self.email)
    self.role = 'user'
    self.settings = "--- \neditor: visual"
  end

  def get_account_id
    letters = ("A".."Z").to_a
    numbers = (0..9).to_a
    acc_id = letters[rand(26)]+letters[rand(26)]+letters[rand(26)]+numbers[rand(10)].to_s+numbers[rand(10)].to_s+numbers[rand(10)].to_s+numbers[rand(10)].to_s+numbers[rand(10)].to_s
    acc_id = self.user_type == 'mentor' ? "M"+acc_id : "L"+acc_id
    if User.exists?(:account_id => acc_id)
      get_account_id
    else
      return acc_id
    end
  end

  def password_required?
    self.new_record? or (!self.password.to_s.blank? or !self.password_confirmation.to_s.blank?)
  end

end
