class User < ApplicationRecord
    has_many :rounds, foreign_key: "creator_id"
    has_many :questions, foreign_key: "creator_id"
    has_many :round_plays
    has_many :played_rounds, through: :round_plays, source: :round

    validates :username, presence: true
end