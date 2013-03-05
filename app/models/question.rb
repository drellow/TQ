class Question < ActiveRecord::Base
  attr_accessible :body, :info, :user_id, :created_at, :emailed_answers

  belongs_to :user
  validates :user_id, :body, :presence => true
  has_many :answers

  def self.todays_question
    today = Time.now.in_time_zone("Pacific Time (US & Canada)")
    Question.where('created_at BETWEEN ? AND ?',
        today.beginning_of_day, today.end_of_day).first
  end

  def self.question_posted?
    !!self.todays_question
  end

  def self.todays_answers
    self.todays_question.answers
  end

  def self.todays_answers_posted?
    self.todays_question.posted_answers?
  end
end
