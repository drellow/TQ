desc "Alright, I'm going to release the answers and email everyone."
task :post_answers => :environment do
  puts "I'mma post answers..."
  if !Question.question_posted?
    puts "There ain't no question today."
  elsif Question.todays_question.posted_answers?
    puts "There ain't no question today..."
  else
    Question.release_todays_question!
    puts "Alright, done."
  end
end

task :email_answers => :environment do
  puts "Time to email some people..."
  if !Question.question_posted?
    puts "There ain't no question today."
  elsif Question.todays_question.emailed_answers?
    puts "I already emailed the answers..."
  else
    Notifier.email_answers
    puts "Alrighty, sent emails..."
  end
end