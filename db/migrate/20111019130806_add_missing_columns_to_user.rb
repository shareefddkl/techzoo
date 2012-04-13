class AddMissingColumnsToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :notify_via_email, :boolean
    add_column :users, :notify_on_new_articles, :boolean
    add_column :users, :notify_on_comments, :boolean
    add_column :users, :profile_id, :integer, :default => 1
    add_column :users, :text_filter_id, :string, :default => "1"
    add_column :users, :settings, :text
    add_column :users, :login, :string, :default => 'admin'
    add_column :users, :name, :string, :default => 'admin'
    add_column :users, :last_connection, :datetime
  end

  def self.down
    remove_column :users, :notify_via_email
    remove_column :users, :notify_on_new_articles
    remove_column :users, :notify_on_comments
    remove_column :users, :profile_id
    remove_column :users, :text_filter_id
    remove_column :users, :settings
    remove_column :users, :login
    remove_column :users, :name
    remove_column :users, :last_connection
  end
end
