require "mysportsfeeds"
require 'net/http'
require 'net/https'
require "base64"

class Player < ApplicationRecord
  has_many :drafts
  has_many :teams, through: :drafts

  # msf = MySportsFeeds.new(version="1.0", true)
  #
  # msf.authenticate("cvolpe", "8m^KgSir3uLpE^l")
  #
  # # data = msf.msf_get_data('mlb', '2019-regular', 'cumulative_player_stats', 'json', 'team' => 'new-york-yankees')
  # data = msf.msf_get_data('nba', '2016-2017-regular', 'player_gamelogs', 'json', 'player' =>'stephen-curry')
  # puts data

  # RestClient.get("https://api.mysportsfeeds.com/v2.1/pull/mlb/2019-regular/player_stats_totals.json")

  def self.create_player
    self.send_request
    self.call_teams
    @currentRoster.each do |player|
      Player.create(
        first_name: player["player"]["firstName"],
        last_name: player["player"]["lastName"],
        team: player["player"]["currentTeam"]["abbreviation"],
        position: player["player"]["primaryPosition"],
        batting_stance: player["player"]["handedness"]["bats"],
        season_batting_avg: player["stats"]["batting"]["battingAvg"],
        season_slugging_pct: player["stats"]["batting"]["batterSluggingPct"],
        season_hits: player["stats"]["batting"]["hits"],
        season_doubles: player["stats"]["batting"]["secondBaseHits"],
        season_triples: player["stats"]["batting"]["thirdBaseHits"],
        season_home_runs: player["stats"]["batting"]["homeRuns"],
        season_runs: player["stats"]["batting"]["runs"],
        season_rbi: player["stats"]["batting"]["runsBattedIn"]
      )
    end
  end

  def self.call_teams
    self.send_request
    @currentRoster = []
    @team.fetch("playerStatsTotals").each do |player|
      if player["player"]["currentRosterStatus"] == "ROSTER" && player["player"]["primaryPosition"] != "P"
        newPlayer = {
          first_name: player["player"]["firstName"],
          last_name: player["player"]["lastName"],
          team: player["player"]["currentTeam"]["abbreviation"],
          position: player["player"]["primaryPosition"],
          batting_stance: player["player"]["handedness"]["bats"],
          season_batting_avg: player["stats"]["batting"]["battingAvg"],
          season_slugging_pct: player["stats"]["batting"]["batterSluggingPct"],
          season_hits: player["stats"]["batting"]["hits"],
          season_doubles: player["stats"]["batting"]["secondBaseHits"],
          season_triples: player["stats"]["batting"]["thirdBaseHits"],
          season_home_runs: player["stats"]["batting"]["homeRuns"],
          season_runs: player["stats"]["batting"]["runs"],
          season_rbi: player["stats"]["batting"]["runsBattedIn"]
        }
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
