class Mentor < ActiveRecord::Base
  belongs_to :user
  after_save :create_user_account_id
  #before_save :make_phone
  attr_accessor :phone1,:phone2,:phone3
  has_many :courses, :dependent => :destroy
  validates :college_name, :presence => { :if => :collge_name_required? }
  validates :city, :presence => { :if => :city_required? }
  validates :board, :presence => { :if => :board_required? }
  validates :stream, :presence => { :if => :stream_required? }
  validates :corexp, :presence => { :if => :corexp_required? }
  validates :qualification, :presence => { :if => :qualification_required? }
  validates :designation, :presence => { :if => :designation_required? }
  validates :degree, :presence => { :if => :degree_required? }
  validates :university,:presence => { :if => :university_required? }
  validates :education,:occupation,:location,:presence => { :if => :good_fields_required? }
  validates :first_name,:last_name,:date_of_birth,:address,:city,:state,:country,:pincode, :presence => true
  private

  def collge_name_required?
    !self.education_type.nil? and ['professor','school','research','professional'].include?(self.education_type)
  end

  def city_required?
    !self.education_type.nil? and ['professor','school','corporate','research','professional'].include?(self.education_type)
  end

  def board_required?
    !self.education_type.nil? and ['professor','school'].include?(self.education_type)
  end

  def stream_required?
    !self.education_type.nil? and  ['professor','corporate','research','professional'].include?(self.education_type)
  end

  def corexp_required?
    !self.education_type.nil? and ['corporate','good'].include?(self.education_type)
  end

  def qualification_required?
    !self.education_type.nil? and ['corporate','research','professional'].include?(self.education_type)
  end

  def degree_required?
    !self.education_type.nil? and  ['corporate','research','professional'].include?(self.education_type)
  end

  def designation_required?
    !self.education_type.nil? and ['research','professional'].include?(self.education_type)
  end

  def university_required?
    !self.education_type.nil? and ['professor'].include?(self.education_type)
  end

  def good_fields_required?
    !self.education_type.nil? and ['good'].include?(self.education_type)
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
    indexes user(:status), :as => :user_status, :sortable => true
    indexes course(:name), :sortable => true
    has user_id, created_at, updated_at
  end
  
  def create_user_account_id
    if !self.education_type.to_s.blank? and self.user and self.user.account_id.to_s.blank?
      self.user.create_account_id
    end
  end
  # for make three section for land_line_no
  def make_phone
    self.lande_line_no = @phone1 + @phone2 + @phone3
  end
  def phone1
    self.lande_line_no.to_s.slice(0,2) if self.lande_line_no 
  end

  def phone2
    self.lande_line_no.to_s.slice(2,4) if self.lande_line_no
  end

  def phone3
    self.lande_line_no.to_s.slice(6,10) if self.lande_line_no
  end
end
