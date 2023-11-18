class AddScoreToUser < ActiveRecord::Migration[7.1]
  def change
    add_reference :users, :score, null: false, foreign_key: true
  end
end
