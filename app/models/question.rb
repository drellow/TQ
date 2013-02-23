class Question < ActiveRecord::Base
  attr_accessible :body, :info, :user_id

  belongs_to :user
  validates :user_id, :body, :presence => true

end
