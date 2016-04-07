class ChangeColComments < ActiveRecord::Migration
  def change
    remove_column :comments, :vote_count
    add_column :comments, :votes_count, :integer, default: 0

  end
end
