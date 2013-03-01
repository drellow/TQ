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
                  :title, :color, :provider, :uid

  validates :username, uniqueness: true

  before_save do |user|
    user.email = email.downcase
  end

  has_many :stars
  has_many :questions
  has_many :answers
  has_many :comments, :through => :answers
  has_many :hero_relationships, :class_name => "Relationship",
           :foreign_key => :fan_id
  has_many :heroes, :through => :hero_relationships
  has_many :fan_relationships, :class_name => "Relationship",
           :foreign_key => :hero_id
  has_many :fans, :through => :fan_relationships

  def self.find_by_facebook_auth(auth)
    user = User.where(:email => auth.info.email).first
    if user
      user.provider = auth.provider
      user.uid = auth.uid
      user.access_token = auth.credentials.token
      user.save!
    else
      user = User.create!(
        provider: auth.provider,
        uid: auth.uid,
        email: auth.info.email,
        username: auth.info.name,
        access_token: auth.credentials.token,
        password: Devise.friendly_token[0,20])
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
    current_answer = self.answers.where('created_at BETWEEN ? AND ?',
                     DateTime.now.beginning_of_day, DateTime.now.end_of_day).first
    if current_answer.nil?
      Answer.new
    else
      current_answer
    end
  end

  MY_COLORS = {
    intense_blue: "#0099FF",
    green_face: "#19DD89",
    fuck: "#2099DA",
    gareen: "#339999",
    glow: "#43B3AE",
    fiftiesgreen: "#44AF69",
    bold_green: "#51b749",
    aeeat: "#81A89D",
    jade: "#84AA97",
    blueyou: "#85CCF8",
    northern_lights: "#97CC91",
    rainforest: "#9AAB9B",
    eat: "#9CC4CD",
    pretty: "#9CC4E4",
    hopital: "#9ECBE1",
    notwhite: "#9ED3F0",
    eden: "#A0C55F",
    revelations: "#A8D26E",
    asix: "#AAAAAA",
    moondrops: "#ABBD99",
    mint: "#B5FFCE",
    frozen: "#BAE4E5",
    aeteat: "#BBE4E6",
    voice: "#BC92F0",
    prettyb: "#BFE5FF",
    booklight: "#C4BBA9",
    words: "#C981C7",
    lightness: "#D5FBFE",
    fish: "#D6DAA8",
    comfort: "#E1E79E",
    prettypink: "#E24864",
    dont: "#E6F8BA",
    desert_wind: "#E9ECD9",
    entranced: "#EBD3ED",
    bluer: "#EBF5FF",
    vaseline: "#EBFFC6",
    lilac: "#EFE3F3",
    pure: "#F2F0FF",
    earae: "#F6C0E3",
    whitetrash: "#F9F2E7",
    rose: "#FD0E67",
    one_candle: "#FEF7F8",
    pink: "#FF3394",
    sick_orang: "#FFC48C",
    kitten_nose: "#FFD0D4",
    chariot: "#FFDBC4",
    buttercake: "#FFED8F",
    gray: "#e1e1e1"
  }



end
