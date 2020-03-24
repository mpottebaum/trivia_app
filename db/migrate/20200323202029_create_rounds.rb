class CreateRounds < ActiveRecord::Migration[6.0]
  def change
    create_table :rounds do |t|
      t.integer :creator_id
      t.string :name
      t.integer :num_questions
      t.timestamps
    end
  end
end
