# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

names = %w(Phil Vithiet Scarlet Tim Pamela Tammy Erik David
           Donald Terry Adam Tracy Stewart Pippy Crime Ryan Bill
           Frank Tooth Drainage Eyeballs)
users = []
answers = []
friend_ids = ["10223202", "10229617", "10234466", "10501553",
              "10736744", "11007241"]

#create admin user
admin = User.new(:username => "christopher", :email => "christopherlives@gmail.com",
       :password => "foobarish", :password_confirmation => "foobarish")
admin.title = UsersHelper.new_title
  admin.color = "rgb(" + (rand(150) + 50).to_s + "," +
                       (rand(150) + 50).to_s + "," +
                       (rand(150) + 50).to_s + ")"
admin.legacy_score = rand(123345)
admin.toggle!(:admin)
admin.skip_confirmation!
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
  user.title = UsersHelper.new_title
  puts user.username
  user.color = "rgb(" + (rand(150) + 50).to_s + "," +
                        (rand(150) + 50).to_s + "," +
                        (rand(150) + 50).to_s + ")"
  user.legacy_score = rand(123345)
  users << user
  user.skip_confirmation!
  user.save!
end

#create friends
5.times do |n|
  user = User.new(:username => "#{names[n]}er", :email => "#{names[n+6]}@baz.com",
           :password => "foobarish", :password_confirmation => "foobarish")
  user.title = UsersHelper.new_title
  user.color = "rgb(" + (rand(150) + 50).to_s + "," +
                        (rand(150) + 50).to_s + "," +
                        (rand(150) + 50).to_s + ")"
  user.uid = friend_ids[n]
  puts user.username
  user.legacy_score = rand(123345)
  user.skip_confirmation!
  users << user
  user.save!
end

20.times do |n|
  10.times do |i|
    answer = users[i].answers.build(:body => "I don't know!", :question_id => n).save!
    answers << answer
  end
end


5.times do |i|
  Question.first.answers.first.comments.build(:user_id => (i + 1), :body => "My comment!").save!
end

puts users