# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
# #
# # Examples:
# #
# #   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
# #   Character.create(name: 'Luke', movie: movies.first)
puts "begin seed"
Player.delete_all
Team.delete_all
League.delete_all
User.delete_all
Draft.delete_all

User.create(username: "user")
League.create(name: "league", participants: 2)
Team.create(user_id: 1, league_id: 1)

Player.call_teams.each do |player|
  Player.create(player)
end

puts "end seed"
