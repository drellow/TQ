class Answer < ActiveRecord::Base
  attr_accessible :body, :question_id, :score, :user_id

  belongs_to :user
  has_many :stars

  validates :body, :user_id, :presence => true


end
