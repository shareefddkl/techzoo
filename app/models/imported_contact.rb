class ImportedContact < ActiveRecord::Base
  validates :email,    :presence => true,      :length => { :maximum => 90, :minimum => 6 }
  belongs_to :user
end
