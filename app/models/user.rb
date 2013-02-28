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
    user = User.where(:provider => auth.provider, :uid => auth.uid).first

    unless user
      user = User.create!(
        provider: auth.provider,
        uid: auth.uid,
        email: auth.info.email,
        # access_token: auth.credentials.token,
        password: Devise.friendly_token[0,20])
    end
    user
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
    green_face:       '#19DD89',
    frozen:           '#BAE4E5',
    dont:             '#E6F8BA',
    pretty:           '#9CC4E4',
    intense_blue:     '#0099FF',
    bold_green:       '#51b749',
    sick_orang:       '#FFC48C',
    kitten_nose:      '#FFD0D4',
    lilac:            '#EFE3F3',
    desert_wind:      '#E9ECD9',
    chariot:          '#FFDBC4',
    gray:             '#e1e1e1',
    asix:             '#AAAAAA',
    rose:             '#FD0E67',
    vaseline:         '#EBFFC6',
    pure:             '#F2F0FF',
    glow:             '#43B3AE',
    lightness:        '#D5FBFE',
    comfort:          '#E1E79E',
    fish:             '#D6DAA8',
    hopital:          '#9ECBE1',
    booklight:        '#C4BBA9',
    whitetrash:       '#F9F2E7',
    northern_lights:  '#97CC91',
    moondrops:        '#ABBD99',
    entranced:        '#EBD3ED',
    gareen:           '#339999',
    fiftiesgreen:     '#44AF69',
    eden:             '#A0C55F',
    one_candle:       '#FEF7F8',
    mint:             '#B5FFCE',
    revelations:      '#A8D26E',
    rainforest:       '#9AAB9B',
    bluer:            '#EBF5FF',
    jade:             '#84AA97',
    buttercake:       '#FFED8F',
    blueyou:          '#85CCF8',
    prettyb:          '#BFE5FF',
    prettypink:       '#E24864',
    pink:             '#FF3394',
    words:            '#C981C7',
    voice:            '#BC92F0',
    fuck:             '#2099DA',
    notwhite:         '#9ED3F0',
    earae:            '#F6C0E3',
    eat:              '#9CC4CD',
    aeteat:           '#BBE4E6',
    aeeat:            '#81A89D',
  }

end
