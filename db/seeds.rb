# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# our first users! Mr & Mrs Test!
User.create([{first_name: 'Mr', last_name: 'Test'},{first_name: 'Mrs', last_name: 'Test'}])
