class Question < ActiveRecord::Base
  belongs_to :user
  validates :user_id, :body, :presence => true
  has_many :answers
  
  def release!
    toggle!(:posted_answers)
  end
  
  def self.release_todays_question!
    todays_question.release!
  end

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
    self.question_posted? and self.todays_question.posted_answers?
  end

  def sorted_answers(current_user)
    answers = self.answers
    if current_user && current_user.provider == "facebook"
      answers.sort_by do |a|
        [current_user.friends_with?(a.user) ? 0 : 1,
          a.score * -1]
      end
    else
      answers.sort_by { |a| a.score * -1}
    end
  end
end
