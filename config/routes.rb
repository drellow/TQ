Tq::Application.routes.draw do
  devise_for :users, :controllers => {
    :omniauth_callbacks => "users/omniauth_callbacks"
  }  
  devise_for :users, :controllers => { :registrations => "registrations" }

  resources :users, :only => [:index, :edit, :update, :destroy]
  resources :questions
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
    resources :comments, :only => [:create, :destroy]
  end

  root :to => 'questions#today'
end
