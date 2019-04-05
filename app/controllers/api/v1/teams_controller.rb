class Api::V1::TeamsController < ApplicationController
  before_action :find_team, only: [:show, :update, :destroy]

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

  def update
    @team.update(team_params)
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
    params.permit(:user_id, :league_id)
  end

  def find_team
    @team = Team.find(params[:id])
  end

end
