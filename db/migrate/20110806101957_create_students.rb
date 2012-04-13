class CreateStudents < ActiveRecord::Migration
  def self.up
    create_table :students do |t|
      t.string :user_id
      t.string :first_name, :limit => 40
      t.string :middle_name, :limit => 40
      t.string :last_name, :limit => 40
      t.date :date_of_birth
      t.text :address
      t.string :city, :limit => 20
      t.string :state, :limit => 30
      t.string :country, :limit => 40
      t.integer :pincode
      t.integer :land_line_no
      t.string :mobile
      t.string :college_name, :limit => 40
      t.string :standard, :limit => 30
      t.string :university, :limit => 40
      t.string :degree, :limit => 20
      t.string :stream, :limit => 30
      t.string :company, :limit => 40
      t.string :designation, :limit => 40
      t.string :qualification, :limit => 30
      t.string :education_type, :limit => 15
      t.string :education
      t.string :occupation
      t.string :working_domain
      t.string :location
      t.timestamps
    end
  end

  def self.down
    drop_table :students
  end
end