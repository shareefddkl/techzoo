class AddMissingColumnsToStudent < ActiveRecord::Migration
  def self.up
    add_column :students, :working, :string
    add_column :students, :more_work_details, :string
    add_column :students, :research_paper, :string
    add_column :students, :research_work, :string
    add_column :students, :misc, :string
  end

  def self.down
    remove_column :students, :designation
    remove_column :students, :more_work_details
    remove_column :students, :research_paper
    remove_column :students, :research_work
    remove_column :students, :misc
  end
end
