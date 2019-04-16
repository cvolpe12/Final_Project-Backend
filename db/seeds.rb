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

User.create(username: "user", password: "123", name: "user", email: "user@user.com")
User.create(username: "test", password: "123", name: "test", email: "test@test.com")
League.create(name: "league", participants: 2, limit: 60000, player_source: "MLB", date_of_games: "20190405")
League.create(name: "league 2", participants: 4, limit: 60000, player_source: "MLB", date_of_games: "20190405")
League.create(name: "league 3", participants: 6, limit: 60000, player_source: "MLB", date_of_games: "20190405")
League.create(name: "league 4", participants: 8, limit: 60000, player_source: "MLB", date_of_games: "20190405")
League.create(name: "league 5", participants: 2, limit: 60000, player_source: "MLB", date_of_games: "20190405")
League.create(name: "league 6", participants: 10, limit: 60000, player_source: "MLB", date_of_games: "20190405")
League.create(name: "league 7", participants: 100, limit: 60000, player_source: "MLB", date_of_games: "20190405")

Player.call_teams.each do |player|
  Player.create(player)
end

puts "end seed"
