class CreateCourses < ActiveRecord::Migration
  def self.up
    create_table :courses do |t|
      t.integer :user_id
      t.string :name, :limit => 50
      t.text :abstract
      t.text :prerequisites
      t.text :course_content
      t.string :language, :limit => 50
      t.string :duration, :limit => 30
      t.string :categories
      t.integer :strength
      t.date :start_date
      t.date :end_date
      t.string :course_type, :limit => 30
      t.string :status, :limit => 20
      t.string :amount
      t.string :course_fee
      t.time :time
      #t.string :description
      t.timestamps
    end
  end

  def self.down
    drop_table :courses
  end
end
