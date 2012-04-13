class Course < ActiveRecord::Base
  has_many :discussions, :dependent => :destroy
  has_many  :documents, :dependent => :destroy
  has_many :comments, :class_name => "CommentsVideo", :foreign_key => :course_id, :dependent => :destroy
  accepts_nested_attributes_for  :documents,  :allow_destroy  => true,:reject_if => proc { |attributes| attributes['document'].blank? }
  #validates_associated :documents, :videos
  has_many :feedbacks,  :dependent => :destroy
  has_many :videos,  :dependent => :destroy
  has_many :ads, :dependent => :destroy
  accepts_nested_attributes_for :videos, :allow_destroy => true,:reject_if =>  proc { |attributes| attributes['video'].blank? }
  #attr_accessible :title
  has_many :courses_students
  has_many :students, :through => :courses_students
  belongs_to :user
  belongs_to :mentor
  #validates :course_type, :presence => true
  validates :name, :presence => true
  validates :abstract, :presence => true
  validates :prerequisites, :presence => true
  validates :course_content, :presence => true
  validates :language,:presence => true
  validate :validate_course_name, :on => :create
  delegate :first_name, :middle_name, :city, :state, :country,:to => :mentor, :prefix => true, :allow_nil => true
  delegate :account_id, :user_type,:to => :user, :prefix => true, :allow_nil => true

  def validate_course_name
    if (self.id.nil? and Course.exists?(:name => self.name, :user_id => self.user_id)) or (self.id and Course.where("name = ? AND user_id = ? and id != ?", self.name, self.user_id, self.id))
      errors.add(:name, "These course is already created by you")
    end

  end

  define_index do
    indexes mentor(:first_name), :as => :mentor_first_name, :sortable => true
    indexes mentor(:middle_name), :as => :mentor_middle_name, :sortable => true
    indexes mentor(:city), :as => :mentor_city, :sortable => true
    indexes mentor(:state), :as => :mentor_state, :sortable => true
    indexes mentor(:country), :as => :mentor_country, :sortable => true
    indexes user(:account_id), :as => :user_account_id, :sortable => true
    indexes user(:user_type), :as => :user_user_type, :sortable => true
    indexes name, :sortable => true
    indexes course_type, :sortable => true
    indexes status, :sortable => true

    # indexes "#{end_date > Date.today ? 'closed' : 'open'}", :as => :validity
  end
end
