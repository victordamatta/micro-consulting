class AddAverageScoreToUsers < ActiveRecord::Migration
  def change
    add_column :users, :score, :decimal
  end
end
