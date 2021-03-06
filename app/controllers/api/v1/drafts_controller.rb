class Api::V1::DraftsController < ApplicationController
  before_action :find_draft, only: [:update, :destroy]

  def index
    @drafts = Draft.all
    render json: @drafts
  end

  def create
    @draft = Draft.new(draft_params)
    # byebug
    if @draft.save
      render json: @draft, status: :accepted
    else
      render json: { errors: @draft.errors.full_messages }, status: :unprocessible_entity
    end
  end

  def update
    @draft.update(draft_params)
    if @draft.save
      render json: @draft, status: :accepted
    else
      render json: { errors: @draft.errors.full_messages }, status: :unprocessible_entity
    end
  end

  def destroy
    @draft.destroy
    head :no_content
  end

  private

  def draft_params
    params.permit(:team_id, :player_id, :extra_player)
  end

  def find_draft
    @draft = Draft.find(params[:id])
  end

end
