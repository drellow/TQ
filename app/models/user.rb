class User < ActiveRecord::Base
  attr_accessible :password, :password_confirmation, :username, :email

  has_secure_password

  validates :password, presence: true, length: { minimum: 6 }
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password_confirmation, presence: true

  before_save do |user|
    user.email = email.downcase
    user.username = username.downcase
  end

  has_many :questions
  has_many :votes
  has_many :answers
  has_many :hero_relationships, :class_name => "Relationship",
           :foreign_key => :fan_id
  has_many :heroes, :through => :hero_relationships
  has_many :fan_relationships, :class_name => "Relationship",
           :foreign_key => :hero_id
  has_many :fans, :through => :fan_relationships


end
