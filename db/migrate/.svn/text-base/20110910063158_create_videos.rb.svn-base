class CreateVideos < ActiveRecord::Migration
  def self.up
    create_table :videos do |t|
      t.string :title, :limit => 20
      t.string :video_file_name, :limit => 40
      t.datetime :video_upload_at
      t.integer :video_file_size
      t.string :video_content_type
      t.string :description
      t.integer :course_id
      t.timestamps
    end
  end

  def self.down
    drop_table :videos
  end
end