class CreateAds < ActiveRecord::Migration
  def self.up
    create_table :ads do |t|
      t.integer :user_id
      t.integer :course_id
      t.boolean :active_all
      t.boolean :active
      t.string :title
      t.text :matter
      t.timestamps
    end
  end

  def self.down
    drop_table :ads
  end
end
