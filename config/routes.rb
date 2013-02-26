Tq::Application.routes.draw do

  devise_for :users

  resources :users, :only => [:index, :edit, :update, :destroy]
  resources :questions
  post '/post_answers', to: 'questions#release'

  resources :answers do
    post 'vote', to: 'answers#vote'
  end

  root :to => 'questions#today'

end
