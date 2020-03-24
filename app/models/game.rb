class Game < ApplicationRecord
    has_many :game_rounds
    has_many :rounds, through: :game_rounds
    belongs_to :creator, class_name: "User"
    has_many :game_round_plays
    has_many :round_plays, through: :game_round_plays
end