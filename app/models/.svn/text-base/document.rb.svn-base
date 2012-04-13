class Document < ActiveRecord::Base
  has_many :discussions, :dependent => :destroy
  belongs_to  :course
  has_attached_file :document, :styles => {  :large => "640*480",  :medium => "300*300>",  :thumb => "100*100>" }
end
