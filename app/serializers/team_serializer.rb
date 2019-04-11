class TeamSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :league_id, :entered
  has_many :players
end
