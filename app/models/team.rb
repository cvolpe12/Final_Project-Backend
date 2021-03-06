require "mysportsfeeds"
require 'net/http'
require 'net/https'
require "base64"

class Team < ApplicationRecord
  belongs_to :user
  belongs_to :league
  has_many :drafts
  has_many :players, through: :drafts

  def get_daily_stats
    if self.entered == true
      self.send_request
      # updatedPlayers = []
      self.players.each do |player| #map?
        @all_players.fetch("gamelogs").each do |dailyPlayer|
          dp_name = dailyPlayer["player"]["firstName"] + " " + dailyPlayer["player"]["lastName"]
          if player.name == dp_name
            # byebug
            player["game_hits"]= dailyPlayer["stats"]["batting"]["hits"]
            puts player["game_hits"]
            player["game_doubles"]= dailyPlayer["stats"]["batting"]["secondBaseHits"]
            player["game_triples"]= dailyPlayer["stats"]["batting"]["thirdBaseHits"]
            player["game_home_runs"]= dailyPlayer["stats"]["batting"]["homeruns"]
            player["game_runs"]= dailyPlayer["stats"]["batting"]["runs"]
            player["game_rbi"]= dailyPlayer["stats"]["batting"]["runsBattedIn"]
            player["game_walks"]= dailyPlayer["stats"]["batting"]["batterWalks"]
          else
            nil
          end #end of name condition
        end #end of all_players do
        puts "outside loop #{player["game_hits"]}"
        puts "saving player"
        puts player.save
        # updatedPlayers.push(player)
      end #end of self do
    end #end of if
    # byebug
    # self.players = updatedPlayers
    # self.save
  end #end of method

  def send_request
    @league = League.find(self.league_id)
    date = @league.date_of_games.split("-").join("")
    uri = URI("https://api.mysportsfeeds.com/v2.1/pull/mlb/2019-regular/date/#{date}/player_gamelogs.json")

    # Create client
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER

    # Create Request
    req =  Net::HTTP::Get.new(uri)
    # Add headers
    req.add_field "Authorization", "Basic " + Base64.encode64(ENV["API_KEY"] + ":" + ENV["API_PASSWORD"])

    # Fetch Request
    res = http.request(req)
    @all_players = JSON.parse(res.body)
    # puts "Response HTTP Status Code: #{res.code}"
    # puts "Response HTTP Response Body: #{res.body}"
    # puts res.body.class
  rescue StandardError => e
    puts "HTTP Request failed (#{e.message})"
  end

end
