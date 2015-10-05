class AddBestToAnswer < ActiveRecord::Migration
  def change
    add_column :answers, :best, :bool
  end
end
