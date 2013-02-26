# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

names = %w(Frank Phil Tom Bill Patty Fred Sam Tommy Topher Charles)
users = []

#create admin user
admin = User.new(:username => "christopher", :email => "admin@bar.com",
       :password => "foobarish", :password_confirmation => "foobarish")
admin.title = admin.new_title
  admin.color = "rgb(" + (rand(150) + 50).to_s + "," +
                       (rand(150) + 50).to_s + "," +
                       (rand(150) + 50).to_s + ")"
admin.toggle!(:admin)
admin.save!

#create today's question
question = admin.questions.build(:body => "When is it too late to laminate?").save!

20.times do |n|
  admin.questions.build(:body => "What is your favorite color?",
                        :created_at => n.days.ago).save!
end

#create basic users
10.times do |n|
  user = User.new(:username => names[n], :email => "#{names[n]}@bar.com",
           :password => "foobarish", :password_confirmation => "foobarish")
  user.title = user.new_title
  user.color = "rgb(" + (rand(150) + 50).to_s + "," +
                       (rand(150) + 50).to_s + "," +
                       (rand(150) + 50).to_s + ")"
  users << user
  user.save!
end

20.times do |n|
  10.times do |i|
    users[i].answers.build(:body => "I don't know!", :question_id => n).save!
  end
end
