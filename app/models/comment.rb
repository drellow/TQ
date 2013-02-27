class Comment < ActiveRecord::Base
  attr_accessible :body, :user_id

  belongs_to :user
  belongs_to :answer

  validates :user_id, :presence => true
  validates :body, :presence => true
end
