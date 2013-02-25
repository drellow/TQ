class Star < ActiveRecord::Base
  attr_accessible :answer_id, :user_id

  belongs_to :answer
  belongs_to :user

  validates :user_id, :uniqueness => { :scope => :answer_id },
                      :presence => true
  validates :answer_id, :presence => true

end
