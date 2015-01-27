class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :answer

  validates :user_id, :presence => true
  validates :body, :presence => true
end
