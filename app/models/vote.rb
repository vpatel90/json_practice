class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :comment, counter_cache: true

  validates :user_id, uniqueness: {
    scope: :comment_id
  }
end
