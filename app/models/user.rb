class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  include UsersHelper
  # Setup accessible (or protected) attributes for your model
  attr_accessible :password, :password_confirmation, :username, :email,
                  :score, :legacy_score, :remember_me

  validates :username, presence: true, uniqueness: true

  before_save do |user|
    user.email = email.downcase
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

  def answered_today?
    self.users_current_answer.valid?
  end

  def users_current_answer
    current_answer = self.answers.where('created_at BETWEEN ? AND ?',
                     DateTime.now.beginning_of_day, DateTime.now.end_of_day).first
    if current_answer.nil?
      Answer.new
    else
      current_answer
    end
  end

end
