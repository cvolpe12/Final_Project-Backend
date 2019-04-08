class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :name, :email
  has_many :teams
  has_many :leagues
end
