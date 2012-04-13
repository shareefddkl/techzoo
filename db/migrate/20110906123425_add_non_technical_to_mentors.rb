class AddNonTechnicalToMentors < ActiveRecord::Migration
  def self.up
    add_column :mentors, :nontechnical, :string
  end

  def self.down
    remove_column :nontechnical, :mentors
  end
end
