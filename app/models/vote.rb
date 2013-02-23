class Vote < ActiveRecord::Base
  attr_accessible :answer_id, :user_id, :score

  belongs_to :answer
  belongs_to :user

  validates :user_id, :uniqueness => { :scope => :answer_id },
                      :presence => true

  validates :score, :inclusion => {:in => [1, 0, -1] },
                    :presence => true
  validates :answer_id, :presence => true

end
