class Game < ApplicationRecord
    has_many :game_rounds, dependent: :destroy
    has_many :rounds, through: :game_rounds
    belongs_to :creator, class_name: "User"
    has_many :game_round_plays, dependent: :destroy
    has_many :round_plays, through: :game_round_plays
    has_many :users, through: :round_plays

    accepts_nested_attributes_for :game_rounds

    validates :name, presence: true

    def current_round_plays(user_id)
        if game_round_plays_remainder(user_id) == 0
            []
        else
            current_game_round_plays(user_id).map {|grp| grp.round_play}
        end
    end

    def current_game_round_plays(user_id)
        remainder = game_round_plays_remainder(user_id)
        all_game_round_plays(user_id).max(remainder) do |grp_1, grp_2|
            grp_1.created_at <=> grp_2.created_at
        end
    end

    def game_round_plays_remainder(user_id)
        all_game_round_plays(user_id).count % rounds.count
    end

    def clear_unfinished_games(user_id)
        remainder = game_round_plays_remainder(user_id)
        if remainder > 0
            unfinished_game_rounds = all_game_round_plays(user_id).max(remainder) do |grp_1, grp_2|
                grp_1.created_at <=> grp_2.created_at
            end
            unfinished_game_rounds.each do |game_round_play|
                game_round_play.destroy
            end
        end
    end

    def all_game_round_plays(user_id)
        game_round_plays.select {|grp| grp.round_play.user_id == user_id}
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

    def last_score_total(user_id)
        scores = last_round_plays(user_id).map {|round_play| round_play.score}
        scores.sum
    end

    def last_round_plays(user_id)
        last_game_round_plays(user_id).map {|grp| grp.round_play}
    end

    def last_game_round_plays(user_id)
        all_game_round_plays(user_id).max(rounds.count) do |grp_1, grp_2|
            grp_1.created_at <=> grp_2.created_at
        end
    end

    def set_round_nums
        game_rounds.each_with_index do |game_round, index|
            game_round.update(round_num: (index + 1))
        end
    end

    def first_game_round_id
        game_rounds.find_by(round_num: 1).id
    end

    def self.most_recent
        all.max(5) do |g_1, g_2|
            g_1.created_at <=> g_2.created_at
        end
    end

    def self.most_played
        all.max(5) do |g_1, g_2|
            g_1.num_plays <=> g_2.num_plays
        end
    end

    def num_plays
        game_round_plays / (rounds.count)
    end

    def all_scores
        users.map do |user|
            [last_score_total(user.id), user]
        end
    end

    def high_scores
        all_scores.max(10) do |s_1, s_2|
            s_1[0] <=> s_2[0]
        end
    end
end