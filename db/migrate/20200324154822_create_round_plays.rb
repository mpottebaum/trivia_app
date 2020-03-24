class CreateRoundPlays < ActiveRecord::Migration[6.0]
  def change
    create_table :round_plays do |t|
      t.integer :user_id
      t.integer :round_id
      t.integer :score
      t.timestamps
    end
  end
end
