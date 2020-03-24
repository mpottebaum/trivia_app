class CreateGameRoundPlays < ActiveRecord::Migration[6.0]
  def change
    create_table :game_round_plays do |t|
      t.integer :round_play_id
      t.integer :game_id
      t.timestamps
    end
  end
end
