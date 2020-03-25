class Game < ApplicationRecord
    has_many :game_rounds
    has_many :rounds, through: :game_rounds
    belongs_to :creator, class_name: "User"
    has_many :game_round_plays
    has_many :round_plays, through: :game_round_plays

    def current_round_plays(user_id)
        round_plays.where(user_id: user_id).max(rounds.count) do |r_p_1, r_p_2|
            r_p_1.created_at <=> r_p_2.created_at
        end
    end

    def round_score(user_id, round)
        round_play = current_round_plays(user_id).detect {|round_play| round_play.round == round}
        if round_play
            round_play.score
        else
            round_play
        end
    end

    def next_round(current_game_round)
        game_rounds.find_by(round_num: (current_game_round.round_num + 1))
    end

    def current_score(user_id)
        if current_round_plays(user_id).empty? == false
            scores = current_round_plays(user_id).map {|round_play| round_play.score}
            scores.sum
        else
            0
        end
    end
end