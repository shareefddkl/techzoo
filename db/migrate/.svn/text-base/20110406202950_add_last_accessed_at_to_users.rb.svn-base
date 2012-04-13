class AddLastAccessedAtToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :last_accessed_at, :datetime
  end

  def self.down
    remove_column :users, :last_accessed_at
  end
end
