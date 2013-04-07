class FeedItem < ActiveRecord::Base
  attr_accessible :body, :path, :scope, :user_id
  
  belongs_to :user

  validates :user_id, :presence => true
  validates :body, :presence => true
end
