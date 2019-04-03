class Api::V1::LeaguesController < ApplicationController

  def index
    @leagues = League.all
    render json: @leagues
  end

  def create
    @league = League.new(league_params)
    if @league.save
      render json: @league, status: :accepted
    else
      render json: { errors: @league.errors.full_messages }, status: :unprocessible_entity
    end
  end

  private

  def league_params
    params.permit(:name, :participants, :limit, :player_source)
  end

  def find_league
    @league = League.find(params[:id])
  end

end
