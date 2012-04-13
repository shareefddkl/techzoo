class AddMissingColumnsToMentor < ActiveRecord::Migration
  def self.up
    add_column :mentors, :employer, :string
    add_column :mentors, :working, :string
    add_column :mentors, :more_work_details, :string
    add_column :mentors, :research_paper, :string
    add_column :mentors, :research_work, :string
    add_column :mentors, :misc, :string
  end

  def self.down
    remove_column :mentors, :employer
    remove_column :mentors, :working
    remove_column :mentors, :more_work_details
    remove_column :mentors, :research_paper
    remove_column :mentors, :research_work
    remove_column :mentors, :misc
  end
end
