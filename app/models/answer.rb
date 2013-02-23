class Answer < ActiveRecord::Base
  attr_accessible :body, :question_id, :score, :user_id

  belongs_to :user
  has_many :votes

  validates :body, :user_id, :presence => true

  def score
    answer_score = votes.select("SUM(score) AS answer_score").first.answer_score
    answer_score.nil? ? 0 : answer_score
  end
end
