class TeamSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :league_id, :entered, :players
  belongs_to :user
  # has_many :players
  # has_many :drafts
  def players
    # byebug
    self.object.drafts.map do |draft|
      new_player = draft.player.attributes
      new_player[:extra_player] = draft.extra_player
      new_player
    end
  end
end
