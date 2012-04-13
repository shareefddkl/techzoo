class CreateMentors < ActiveRecord::Migration
  def self.up
    create_table :mentors do |t|
      t.string :user_id
      t.string :first_name, :limit => 100
      t.string :middle_name, :limit => 100
      t.string :last_name, :limit => 100
      t.date :date_of_birth
      t.text :address
      t.string :city, :limit => 50
      t.string :state, :limit => 50
      t.string :country, :limit => 30
      t.integer :pincode
      t.integer :lande_line_no
      t.string :mobile, :limit => 15
      t.string :college_name, :limit => 50
      t.string :standard
      t.string :board, :limit => 100
      t.string :university
      t.string :degree, :limit => 50
      t.string :stream, :limit => 50
      t.string :designation, :limit => 50
      t.string :qualification, :limit => 50
      t.string :corexp
      t.string :education
      t.string :occupation
      t.string :work
      t.string :location
      t.string :education_type, :limit => 15
      t.timestamps
    end
  end

  def self.down
    drop_table :mentors
  end
end