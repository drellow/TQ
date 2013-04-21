class Suggestion < ActiveRecord::Base
  attr_accessible :body, :score, :user_id
  
  validates :body, :user_id, :presence => true
  
  belongs_to :user
end
