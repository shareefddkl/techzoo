class Suggestion < ActiveRecord::Base
   validates :email,
    :presence => true,
     :length => { :maximum => 90, :minimum => 6 },
    :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
  validates :subject, :body, :presence => true
end
