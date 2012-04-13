class CreateCommentsVideos < ActiveRecord::Migration
  def self.up
    create_table :comments_videos do |t|
      t.integer :course_id
      t.integer :user_id
      t.integer :video_id
      t.text :comment
      t.timestamps
    end
  end

  def self.down
    drop_table :comments_videos
  end
end
