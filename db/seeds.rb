# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all

u1 = User.create! name:'Sree', email: 'sree@tp.co', password: 'chicken'
u2 = User.create! name:'Sam', email: 'sam@tp.co', password: 'chicken'
u3 = User.create! name:'Max', email: 'max@tp.co', password: 'chicken'

puts "Created #{User.count} users."


Destination.destroy_all

d1 = Destination.create! name:'Mauritius', image:'/assets/mauritius.jpg'
d2 = Destination.create! name:'Paris', image:'/assets/paris.jpg'
d3 = Destination.create! name:'Spain', image:'/assets/spain.jpg'

puts "Created #{Destination.count} destinations."

d1.users << u1 << u2

d2.users << u3

d3.users << u1 << u3

puts "User #{u1.name} wants to go to #{u1.destinations.pluck(:name).join(', ')}"

Attraction.destroy_all

attr1 = Attraction.create! name:'Port Louis'
attr2 = Attraction.create! name:'Eiffel Tower'
attr3 = Attraction.create! name:'Casa Mila'
attr4 = Attraction.create! name: 'Vallée des Couleurs visit'
attr5 = Attraction.create! name: 'Ebony Forest Discovery Tour'

puts " #{Attraction.count} attractions created!!"

Hotel.destroy_all

h1 = Hotel.create! name:'Novotel', price: 200
h2 = Hotel.create! name:'Radisson', price: 200
h3 = Hotel.create! name:'Sol Pelicanos', price: 90
h4 = Hotel.create! name:'Eurostars Rey Don Jamie', price: 68
h5 = Hotel.create! name:'Hotel Samos', price: 75

puts "#{Hotel.count} hotels created!!"

Activity.destroy_all

act1 = Activity.create! name: 'Scuba diving', price: 150
act2 = Activity.create! name: 'La Ballon de Paris', price: 100
act3 = Activity.create! name: 'Bull fight', price: 100
act4 = Activity.create! name: 'Beer Bike Bar Tour', price: 45
act5 = Activity.create! name: 'Quad city tour', price: 105

puts "#{Activity.count} activities created!!"

d1.attractions << attr1 << attr4 << attr5
d2.attractions << attr2
d3.attractions << attr3

d1.hotels << h1
d2.hotels << h2
d3.hotels << h3 << h4 << h5

d1.activities << act1
d2.activities << act2 << act4 << act5
d3.activities << act3
