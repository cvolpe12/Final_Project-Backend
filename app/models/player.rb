require "mysportsfeeds"
require 'net/http'
require 'net/https'
require "base64"

class Player < ApplicationRecord
  has_many :drafts
  has_many :teams, through: :drafts

  # def concat_name(player)
  #   player["player"]["firstName"] + " " + player["player"]["lastName"]
  # end

  def self.call_teams
    self.send_request
    @currentRoster = []
    @team.fetch("playerStatsTotals").each do |player|
      # full_name = concat_name(player)
      if player["player"]["currentRosterStatus"] == "ROSTER" && player["player"]["primaryPosition"] != "P"
        if player["player"]["primaryPosition"] == "RF" || player["player"]["primaryPosition"] == "LF" || player["player"]["primaryPosition"] == "CF"
          newPlayer = {
            name: player["player"]["firstName"] + " " + player["player"]["lastName"],
            team: player["player"]["currentTeam"]["abbreviation"],
            position: "OF",
            batting_stance: player["player"]["handedness"]["bats"],
            season_batting_avg: player["stats"]["batting"]["battingAvg"],
            season_slugging_pct: player["stats"]["batting"]["batterSluggingPct"],
            season_hits: player["stats"]["batting"]["hits"],
            season_doubles: player["stats"]["batting"]["secondBaseHits"],
            season_triples: player["stats"]["batting"]["thirdBaseHits"],
            season_home_runs: player["stats"]["batting"]["homeruns"],
            season_runs: player["stats"]["batting"]["runs"],
            season_rbi: player["stats"]["batting"]["runsBattedIn"],
            season_walks: player["stats"]["batting"]["batterWalks"]
          }
        else
          newPlayer = {
            name: player["player"]["firstName"] + " " + player["player"]["lastName"],
            team: player["player"]["currentTeam"]["abbreviation"],
            position: player["player"]["primaryPosition"],
            batting_stance: player["player"]["handedness"]["bats"],
            season_batting_avg: player["stats"]["batting"]["battingAvg"],
            season_slugging_pct: player["stats"]["batting"]["batterSluggingPct"],
            season_hits: player["stats"]["batting"]["hits"],
            season_doubles: player["stats"]["batting"]["secondBaseHits"],
            season_triples: player["stats"]["batting"]["thirdBaseHits"],
            season_home_runs: player["stats"]["batting"]["homeruns"],
            season_runs: player["stats"]["batting"]["runs"],
            season_rbi: player["stats"]["batting"]["runsBattedIn"],
            season_walks: player["stats"]["batting"]["batterWalks"]
          }
        end
        # name = player["player"]["firstName"] + player["player"]["lastName"]
        @currentRoster.push(newPlayer)
      end
    end
    @currentRoster
  end

  # Request (GET )
  def self.send_request
    uri = URI("https://api.mysportsfeeds.com/v2.1/pull/mlb/2019-regular/player_stats_totals.json")

    # Create client
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER

    # Create Request
    req =  Net::HTTP::Get.new(uri)
    # Add headers
    req.add_field "Authorization", "Basic " + Base64.encode64("b97d4ddc-f321-40b5-a2e4-784878" + ":" + "MYSPORTSFEEDS")

    # Fetch Request
    res = http.request(req)
    @team = JSON.parse(res.body)
    # puts "Response HTTP Status Code: #{res.code}"
    # puts "Response HTTP Response Body: #{res.body}"
    # puts res.body.class
  rescue StandardError => e
    puts "HTTP Request failed (#{e.message})"
  end

end
