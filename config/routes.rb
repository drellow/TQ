Tq::Application.routes.draw do

  resources :users
  resources :questions

  root :to => 'questions#today'
end
