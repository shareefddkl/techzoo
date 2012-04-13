class CreateNotifications < ActiveRecord::Migration
  def self.up
    create_table :notifications do |t|
      t.integer :content_id
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :notifications
  end
end
