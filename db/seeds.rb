# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

names = %w(Frank Phil Tom Bill Patty Fred Sam Tom Topher Charles)
users = []

#create admin user
user = User.new(:username => "admin", :email => "admin@bar.com",
           :password => "foobar", :password_confirmation => "foobar")
user.title = user.new_title
  user.color = "rgb(" + (rand(150) + 50).to_s + "," +
                       (rand(150) + 50).to_s + "," +
                       (rand(150) + 50).to_s + ")"
user.toggle!(:admin)
user.save!

#create today's question
question = user.questions.build(:body => "When is it too late to laminate?").save!

#create basic users
10.times do |n|
  user = User.new(:username => names[n], :email => "#{names[n]}@bar.com",
           :password => "foobar", :password_confirmation => "foobar")
  user.title = user.new_title
  user.color = "rgb(" + (rand(150) + 50).to_s + "," +
                       (rand(150) + 50).to_s + "," +
                       (rand(150) + 50).to_s + ")"
  users << user
  user.save!
end

10.times do |n|
  users[n].answers.build(:body => "I don't know!", :question_id => 1).save!
end