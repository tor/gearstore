# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(username: 'tor', name: 'Tor Lattimore', admin: true, email: 'tor.lattimore@gmail.com')
User.create(username: 'ralph', name: 'Ralph Lattimore', admin: false, email: 'ralph.lattimore@gmail.com')
User.create(username: 'rosina', name: 'Rosina Muir', admin: false, email: 'rosina.muir@gmail.com')
User.create(username: 'kirill', name: 'Kirill Talenine', admin: true, email: 'kirill.talenine@gmail.com')

