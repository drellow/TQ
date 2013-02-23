class Relationship < ActiveRecord::Base
  attr_accessible :fan_id, :hero_id

  belongs_to :fan, :class_name => "User"
  belongs_to :hero, :class_name => "User"
end
