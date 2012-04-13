class CreateDiscussions < ActiveRecord::Migration
  def self.up
    create_table :discussions do |t|
      t.integer :course_id
      t.integer :user_id
      t.integer :document_id
      t.text :comment
      t.timestamps
    end
  end

  def self.down
    drop_table :discussions
  end
end
