class Relationship < ActiveRecord::Base
  belongs_to :fan, :class_name => "User"
  belongs_to :hero, :class_name => "User"
end
