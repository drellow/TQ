FactoryGirl.define do

  factory :user do
    sequence(:username) { |n| "person#{n}" }
    sequence(:email) { |n| "person#{n}@bar.com" }
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end

  factory :question do
    body "When is it too late to laminate"
    user_id 1
  end

  factory :answer do
    body "It is never too late to laminate"
    user_id 2
    question_id 1
  end

end