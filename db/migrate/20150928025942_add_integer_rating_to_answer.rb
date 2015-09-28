class AddIntegerRatingToAnswer < ActiveRecord::Migration
  def change
    add_column :answers, :rating, :integer
  end
end
