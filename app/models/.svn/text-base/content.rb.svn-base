class Content < ActiveRecord::Base
  self.establish_connection :typo
  define_index do
    indexes title, :sortable => true
    indexes body, :sortable => true
  end
end
