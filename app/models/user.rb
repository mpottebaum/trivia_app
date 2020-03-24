class User < ApplicationRecord
    has_many :games, foreign_key: "creator_id"
    has_many :rounds, foreign_key: "creator_id"
    has_many :questions, foreign_key: "creator_id"
    has_many :round_plays
    has_many :played_rounds, through: :round_plays, source: :round
    has_many :game_round_plays, through: :round_plays
    has_many :played_games, through: :game_round_plays, source: :game

    validates :username, presence: true
    has_secure_password
end