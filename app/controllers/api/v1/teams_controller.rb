class Api::V1::TeamsController < ApplicationController
  before_action :find_team, only: [:show, :submit_team, :update, :destroy]

  def index
    @teams = Team.all
    render json: @teams
  end

  def create
    @team = Team.new(team_params)
    if @team.save
      render json: @team, status: :accepted
    else
      render json: { errors: @team.errors.full_messages }, status: :unprocessible_entity
    end
  end

  def show
    render json: @team
  end

  def submit_team
    @team.update(team_params)
    @team.get_daily_stats
    # byebug
    if @team.save
      render json: @team, status: :accepted
    else
      render json: { errors: @team.errors.full_messages }, status: :unprocessible_entity
    end
  end

  def update
    @team.update(team_params)
    # @team.get_daily_stats
    if @team.save
      render json: @team, status: :accepted
    else
      render json: { errors: @team.errors.full_messages }, status: :unprocessible_entity
    end
  end

  def destroy
    @team.destroy
    head :no_content
  end

  private

  def team_params
    params.permit(:user_id, :league_id, :entered)
  end

  def find_team
    @team = Team.find(params[:id])
  end

end
