class CreateFeedbacks < ActiveRecord::Migration
  def self.up
    create_table :feedbacks do |t|
      t.integer :course_id
      t.integer :user_id
      t.text :comment
      t.float :communication_skills
      t.float :teaching_skill
      t.float :course_material
      t.float :doubt_clearence
      t.float :subject_knowledge
      t.timestamps
    end
  end

  def self.down
    drop_table :feedbacks
  end
end
