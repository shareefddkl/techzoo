class CreateSuggestions < ActiveRecord::Migration
  def self.up
    create_table :suggestions do |t|
      t.string :email
      t.string :subject
      t.string :suggestion_type
      t.text :body
      t.timestamps
    end
  end

  def self.down
    drop_table :suggestions
  end
end
