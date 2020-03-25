class CreateRoundGroupRounds < ActiveRecord::Migration[6.0]
  def change
    create_table :round_group_rounds do |t|
      t.integer :round_group_id
      t.integer :round_id

      t.timestamps
    end
  end
end
