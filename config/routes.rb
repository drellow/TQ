Tq::Application.routes.draw do

  resources :users
  resources :questions
  resources :answers

  root :to => 'questions#today'


  resources :sessions, only: [:new, :create, :destroy]
  match '/logout', to: 'sessions#destroy', via: :delete
  match '/login', to: 'sessions#new'
end
