class Question < ActiveRecord::Base
  attr_accessible :body, :info, :user_id, :created_at

  belongs_to :user
  validates :user_id, :body, :presence => true
  has_many :answers

  def self.todays_question
    Question.where('created_at BETWEEN ? AND ?',
    DateTime.now.beginning_of_day, DateTime.now.end_of_day).first
  end

  def self.question_posted?
    !!self.todays_question
  end

  def self.todays_answers
    self.todays_question.answers
  end

end
