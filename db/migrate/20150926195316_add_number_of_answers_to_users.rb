class AddNumberOfAnswersToUsers < ActiveRecord::Migration
  def change
    add_column :users, :number_of_answers, :integer
  end
end
