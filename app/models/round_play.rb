class RoundPlay < ApplicationRecord
    belongs_to :user
    belongs_to :round
    has_one :game_round_play

    def score_round(answer_params)
        score = 50 * round.count_num_correct(answer_params)
        update(score: score)
    end
end