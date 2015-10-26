class RemoveNumberOfAnswersFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :integer, :number_of_answers
  end
end
