class Question < ApplicationRecord
    has_many :round_questions
    has_many :rounds, through: :round_questions
    belongs_to :creator, class_name: "User"

    validates_presence_of :question, :answer
end