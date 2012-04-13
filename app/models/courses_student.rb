class CoursesStudent < ActiveRecord::Base
  belongs_to :course
  belongs_to :student
  before_create :assign_default_values
  def assign_default_values
    self.status = 'pending'
  end
end
