class Round < ApplicationRecord
    belongs_to :creator, class_name: "User"
    has_many :round_questions
    has_many :questions, through: :round_questions
    has_many :round_plays
    has_many :users, through: :round_plays
    has_many :game_rounds
    has_many :games, through: :game_rounds
    has_many :round_group_rounds
    has_many :round_groups, through: :round_group_rounds

    validates :name, presence: true

    accepts_nested_attributes_for :questions

    def build_empty_questions(num_questions)
        num_questions.times do
            questions.build
        end
    end

    def count_num_correct(answer_params)
        num_correct = 0
        answer_params["questions"].each_value do |params|
            if check_answer(params) == true
                num_correct += 1
            end
        end
        num_correct
    end
    
    def check_answer(question_params)
        question = Question.find(question_params["id"])
        question_params["answer"].downcase == question.answer.downcase
    end

    def self.compile_rounds_from_round_groups(round_group_ids)
        rounds = []
        round_group_ids.each do |id|
            round_group = RoundGroup.find(id)
            round_group.rounds.each do |round|
                rounds << round
            end
        end
        rounds.uniq
    end
end