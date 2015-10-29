class AddBestAnswersToUsers < ActiveRecord::Migration
  def change
    add_column :users, :best_answers, :integer
  end
end
