class AddNewAnswersToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :new_answers, :boolean
  end
end
