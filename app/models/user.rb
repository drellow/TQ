class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:facebook]
  devise :confirmable
  include UsersHelper
  # Setup accessible (or protected) attributes for your model
  attr_accessible :password, :password_confirmation, :username,
                  :email, :score, :legacy_score, :remember_me,
                  :title, :color, :provider, :uid, :access_token,
                  :reset_password_token, :receives_email

  before_save do |user|
    user.email = email.downcase
  end

  has_many :questions
  has_many :answers
  has_many :comments, :through => :answers
  has_many :hero_relationships, :class_name => "Relationship",
           :foreign_key => :fan_id
  has_many :heroes, :through => :hero_relationships
  has_many :fan_relationships, :class_name => "Relationship",
           :foreign_key => :hero_id
  has_many :fans, :through => :fan_relationships
  has_many :suggestions

  def feed_items
    FeedItem.where(:user_id => self.id).sort_by do |feeditem|
      [feeditem.read? ? 1 : 0,
       -1 * feeditem.created_at.to_i]
    end[0..10]
  end
  
  def maybe_generate_feed_item
    if rand(50) == 7
      feed_item = FeedItemsHelper.bullshit_feed_item
      FeedItem.create!(:user_id => self.id, :body => feed_item,
                      :scope => rand(90000), :path => '/')
    end
  end
  
  def unread_item_count
    FeedItem.where(:user_id => self.id, :read => false).count
  end

  def self.find_by_facebook_auth(auth)
    user = User.where(:email => auth.info.email).first
    if user
      user.provider = auth.provider
      user.uid = auth.uid
      user.access_token = auth.credentials.token
      user.save!
    else
      user = User.new
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.username = auth.info.name
      user.access_token = auth.credentials.token
      user.password = Devise.friendly_token[0,20]
      user.skip_confirmation!
      user.save!
      user.send_reset_password_instructions
    end
    user
  end

  def friends
    if @friends
      @friends
    else
      graph = Koala::Facebook::API.new(self.access_token)
      graph.get_object("me")
      @friends = graph.get_connections("me", "friends")
    end
  end

  def friends_with?(user)
    friends.each do |friend|
     return true if friend["id"] == user.uid
    end
    false
  end

  def answered_today?
    self.users_current_answer.valid?
  end

  def users_current_answer
    current_answer = Question.todays_question.answers.where(:user_id => id).first

    if current_answer.nil?
      Answer.new
    else
      current_answer
    end
  end
end
