class Question < ActiveRecord::Base
  attr_accessible :body, :info, :user_id, :created_at

  belongs_to :user
  validates :user_id, :body, :presence => true
  has_many :answers

  def self.todays_question
    # REV: indent broken line two spaces. Looks like you have an
    # unclosed method call.
    Question.where('created_at BETWEEN ? AND ?',
    DateTime.now.beginning_of_day, DateTime.now.end_of_day).first
  end

  def self.question_posted?
    !!self.todays_question
  end

  # REV: This should be a method on Answer
  def self.todays_answers
    self.todays_question.answers
  end

end
