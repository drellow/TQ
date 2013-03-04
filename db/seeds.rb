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
questions = ["When is it too late to laminate?", "How tall is your grandmother?",
             "Which clock is the best clock?", "Would you like to argue with a
             sasquatch?", "Who ate all the corn?", "What time is it?", "Why is
             your tub shrinking?", "Would you ruin your life for a jamboree?",
             "Do you have time for handball?", "Do you like wheat?", "Are you looking
             for a good reason to floss?"]
answer_body = ["Oh man I really love this question. I'm just so stoked to be
          here today, thanks so much to my family.", "The last time someone
          asked me this, I pretended I didn't know them.", "What do you mean,
          I mean, isn't it obvious?", "I once drove from Pittsburgh Pennsylvania
          to Boulder Colorado without stopping. We only stopped because we'd
          accidently slipped the car into Overdrive and thought we'd done something
          to the engine. In reality, we were just too tired to notice. Then my
          brother and I and my buddy all fell asleep in the sauna and woke up afraid
          we were going to die.", "I once saw a bear in the woods. My buddies saw it
          first and hollered at me to 'look at that!' but I was adjusting the straps
          on my backpack and would have otherwise walked right into the thing.", "Aldous
          Huxley once said the the principle function of a friend is to suffer in mild
          and symbolic form the punishments we would like to but are unable to inflict
          upon our enemies.", "Sometimes I get scared. They mostly come out at night,
          though. Mostly.", "Wouldn't it be alright if just once we could talk through
          the whole night and by the morning I'd still be interested in what we were
          talking about. I feel like that used to happen."]

#create admin user
admin = User.new(:username => "christopher", :email => "christopherlives@gmail.com",
       :password => "foobarish", :password_confirmation => "foobarish")
admin.skip_confirmation!
admin.title = UsersHelper.new_title
  admin.color = "rgb(" + (rand(150) + 50).to_s + "," +
                       (rand(150) + 50).to_s + "," +
                       (rand(150) + 50).to_s + ")"
admin.legacy_score = rand(123345)
admin.toggle!(:admin)
admin.save!

#create today's question
question = admin.questions.build(:body => questions.sample).save!

20.times do |n|
  admin.questions.build(:body => questions.sample,
                        :created_at => (n+2).days.ago).save!
end

#create basic users
6.times do |n|
  user = User.new(:username => names[n], :email => "#{names[n]}@bar.com",
           :password => "foobarish", :password_confirmation => "foobarish")
  user.title = UsersHelper.new_title
  puts user.username
  user.color = "rgb(" + (rand(150) + 50).to_s + "," +
                        (rand(150) + 50).to_s + "," +
                        (rand(150) + 50).to_s + ")"
  user.uid = friend_ids[n]
  user.legacy_score = rand(123345)
  users << user
  user.skip_confirmation!
  user.save!
end

#create friends
9.times do |n|
  user = User.new(:username => "#{names[n+6]}er", :email => "#{names[n+6]}@baz.com",
           :password => "foobarish", :password_confirmation => "foobarish")
  user.title = UsersHelper.new_title
  user.color = "rgb(" + (rand(150) + 50).to_s + "," +
                        (rand(150) + 50).to_s + "," +
                        (rand(150) + 50).to_s + ")"
  puts user.username
  user.legacy_score = rand(123345)
  user.skip_confirmation!
  users << user
  user.save!
end

20.times do |n|
  10.times do |i|
    answer = users[i].answers.build(:body => answer_body.sample, :question_id => n).save!
    answers << answer
  end
end


7.times do |i|
  Question.first.answers.first.comments.build(:user_id => (i + 1), :body => answer_body.sample).save!
end

puts users