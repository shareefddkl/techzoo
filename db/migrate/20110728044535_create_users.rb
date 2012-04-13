class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :email, :limit => 100
      t.string :hashed_password, :limit => 100
      t.string :salt, :limit => 100
      t.string :activation_code, :limit => 100
      t.datetime :activated_at
      t.string :user_type, :limit => 20
      t.string :account_id, :limit => 100
      t.string :email_encrypted, :limit => 100
      t.string :reset_password_code, :limit => 100
      t.date :last_password_reseted_at
      t.string :role, :limit => 20
      t.string :status, :limit => 20
      t.date :last_logged_in_at
      t.integer :login_failed_count
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end

end
