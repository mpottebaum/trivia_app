class RemoveNumQuestionsFromRounds < ActiveRecord::Migration[6.0]
  def change
    remove_column :rounds, :num_questions
  end
end
