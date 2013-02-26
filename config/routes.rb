Tq::Application.routes.draw do

  devise_for :users

  resources :users, :only => [:index, :edit, :update, :destroy]
  resources :questions
  resources :answers

  root :to => 'questions#today'
  match '/post_answers', to: 'questions#release'
  match '/answer_vote', to: 'answers#vote'
end
