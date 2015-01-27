class Star < ActiveRecord::Base
  belongs_to :answer
  belongs_to :user

  validates :user_id, :uniqueness => { :scope => :answer_id },
                      :presence => true
  validates :answer_id, :presence => true
end
