class CommentsVideo < ActiveRecord::Base
   belongs_to :video
  belongs_to :course
  belongs_to :user
end
