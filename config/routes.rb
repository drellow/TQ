Tq::Application.routes.draw do
  devise_for :users, :controllers => {
    :omniauth_callbacks => "users/omniauth_callbacks", 
    :registrations => "registrations"
  }  

  resources :users, :only => [:index, :edit, :update, :destroy]
  resources :questions
  resources :suggestions, :only => [:index, :create]
  resources :suggestions do
    post 'vote', to: 'suggestions#vote'
    post 'toggle_archive', to: 'suggestions#toggle_archive'
  end
  get '/about', to: 'static_pages#about'
  get '/admin_dashboard', to: 'admin_dashboard#dashboard'
  get '/admin_answers', to: 'answers#admin_answers'
  post '/email_question', to: 'admin_dashboard#email_question'
  post '/email_answers', to: 'admin_dashboard#email_answers'
  post '/post_answers', to: 'questions#release'
  get '/silly_title', to: 'sillytitles#new'
  get '/scoreboard', to: 'users#scoreboard'
  post '/reset_password', to: 'users#reset_password'

  resources :answers do
    post 'vote', to: 'answers#vote'
    resources :comments, :only => [:create, :destroy, :update]
  end
  resources :feed_items, :only => :update

  root :to => 'questions#today'
end
