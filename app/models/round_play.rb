class RoundPlay < ApplicationRecord
    belongs_to :user
    belongs_to :round
    has_many :game_round_plays

    def score_round(answer_params)
        score = 50 * round.count_num_correct(answer_params)
        update(score: score)
    end
end