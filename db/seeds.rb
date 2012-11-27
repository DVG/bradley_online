# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
if (AdminUser.all.size == 0)
  AdminUser.create!(:email => 'devryguy@gmail.com', :password => 'secret', :password_confirmation => 'secret', :username => 'Bradley')
end