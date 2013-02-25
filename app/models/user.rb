class User < ActiveRecord::Base
  attr_accessible :password, :password_confirmation, :username, :email,
                  :score, :legacy_score

  has_secure_password

  validates :password, presence: true, length: { minimum: 6 }
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password_confirmation, presence: true

  before_save do |user|
    user.email = email.downcase
    user.username = username.downcase
    user.score = 100
    user.legacy_score = 100
  end

  has_many :stars
  has_many :questions
  has_many :answers
  has_many :hero_relationships, :class_name => "Relationship",
           :foreign_key => :fan_id
  has_many :heroes, :through => :hero_relationships
  has_many :fan_relationships, :class_name => "Relationship",
           :foreign_key => :hero_id
  has_many :fans, :through => :fan_relationships

  def refresh_token
    token = SecureRandom.urlsafe_base64
    self.update_attribute(:session_token, token)
  end

  def answered_today?
    !!users_current_answer
  end

  def users_current_answer
    self.answers.where('created_at BETWEEN ? AND ?',
    DateTime.now.beginning_of_day, DateTime.now.end_of_day).first
  end


end
