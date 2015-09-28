class RemoveDecimalRatingFromAnswer < ActiveRecord::Migration
  def change
    remove_column :answers, :rating, :decimal
  end
end
