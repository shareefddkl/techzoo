class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.integer :user_id
      t.integer :receiver_id
      t.text :body
      t.string :user_status, :limit => 10
      t.string :receiver_status, :limit => 10
      t.timestamps
    end
  end

  def self.down
    drop_table :messages
  end
end
