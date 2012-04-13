class AddNotificationColumnToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :every_new_course, :string, :limit => 15
    add_column :users, :course_related, :string, :limit => 40
    add_column :users, :categories_type, :string, :limit => 15
    add_column :users, :course_accept_reject, :string, :limit => 15
  end

  def self.down
    remove_column :users, :every_new_course
    remove_column :users, :course_related
    remove_column :users, :categories_type
    remove_column :users,:course_accept_reject
  end
end
