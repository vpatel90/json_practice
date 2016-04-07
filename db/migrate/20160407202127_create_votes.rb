class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :comment, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_column :comments, :vote_count, :integer, default: 0
  end
end
