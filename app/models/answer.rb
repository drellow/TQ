class Answer < ActiveRecord::Base
  attr_accessible :body, :question_id, :score, :user_id

  belongs_to :user
  belongs_to :question
  has_many :stars
  has_many :comments

  validates :body, :user_id, :question_id, :presence => true
end
