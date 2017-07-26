class Question < ActiveRecord::Base
  belongs_to :user
  has_many :downvotes
  has_many :upvotes
end
