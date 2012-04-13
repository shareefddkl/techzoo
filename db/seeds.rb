# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
Admino.create({:email => 'admin@gmail.com', :password => 'admin123', :password_confirmation => 'admin123', :user_type => 'admin', :account_id => 'AAAV57', :role => 'admin', :status => 'active'})
