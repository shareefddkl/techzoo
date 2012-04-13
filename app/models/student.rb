class Student < ActiveRecord::Base
  belongs_to :user
  has_many :courses_students
  has_many :courses, :through => :courses_students
  validates :college_name, :presence => { :if => :collge_name_required? }
  validates :standard, :presence => { :if => :standard_required? }
  validates :university, :presence => {:if => :university_required? }
  validates :degree, :presence => { :if => :degree_required?}
  validates :stream, :presence => { :if => :stream_required?}
  validates :city, :presence => { :if => :city_required?}
  validates :education,:occupation,:working_domain,:location, :title, :presence =>  { :if => :others_education_fields_required?}
  validates :city,:first_name,:middle_name,:last_name,:date_of_birth,:address,:state,:country,:pincode, :presence => true
  after_save :create_user_account_id
#  before_update :make_phone
  attr_accessor :phone1,:phone2,:phone3
  private

  def collge_name_required?
    !self.education_type.nil? and ["in_school", "college", "pg", "phd"].include?(self.education_type)
  end

  def standard_required?
    !self.education_type.nil? and ["in_school"].include?(self.education_type)
  end

  def university_required?
    !self.education_type.nil? and ["in_school","college","pg","phd"].include?(self.education_type)
  end

  def degree_required?
    !self.education_type.nil? and ["college","pg","phd","professional"].include?(self.education_type)
  end

  def stream_required?
    !self.education_type.nil? and ["college","pg","phd","professional"].include?(self.education_type)
  end

  def city_required?
    !self.education_type.nil? and ["in_school","college","pg","phd","professional"].include?(self.education_type)
  end

  def others_education_fields_required?
    !self.education_type.nil? and ["others"].include?(self.education_type)
  end

  def create_user_account_id
    if !self.education_type.to_s.blank? and self.user and self.user.account_id.to_s.blank?
      self.user.create_account_id
    end
  end

  # for make three section for land_line_no
  def make_phone
    self.land_line_no = @phone1 + @phone2 + @phone3
  end
  
  def phone1
    self.land_line_no.to_s.slice(0,2) if self.land_line_no
  end

  def phone2
    self.land_line_no.to_s.slice(2,4) if self.land_line_no
  end

  def phone3
    self.land_line_no.to_s.slice(6,10) if self.land_line_no
  end

  delegate :account_id, :user_type,:to => :user, :prefix => true, :allow_nil => true
  define_index do
    indexes first_name, :sortable => true
    indexes last_name, :sortable => true
    indexes user(:account_id), :as => :user_account_id,:sortable => true
    indexes education_type, :sortable => true
    indexes user(:user_type), :as => :user_user_type, :sortable => true
    indexes city, :sortable => true
    indexes state, :sortable => true
    indexes country, :sortable => true
    has user_id, created_at, updated_at
  end
end