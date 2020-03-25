class RoundGroup < ApplicationRecord
    belongs_to :user
    has_many :round_group_rounds
    has_many :rounds, through: :round_group_rounds
end
