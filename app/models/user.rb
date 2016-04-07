class User < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  has_many :comments

  validates :name, presence: true
end
