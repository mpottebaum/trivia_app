class CreateGameRounds < ActiveRecord::Migration[6.0]
  def change
    create_table :game_rounds do |t|
      t.integer :game_id
      t.integer :round_id
      t.integer :round_num
      t.timestamps
    end
  end
end
