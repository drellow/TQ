Tq::Application.routes.draw do

  devise_for :users, :controllers => {
    :omniauth_callbacks => "users/omniauth_callbacks"
  }
  resources :users, :only => [:index, :edit, :update, :destroy]
  resources :questions
  post '/post_answers', to: 'questions#release'
  get '/silly_title', to: 'sillytitles#new'
  get '/scoreboard', to: 'users#scoreboard'

  resources :answers do
    post 'vote', to: 'answers#vote'
    resources :comments, :only => [:create, :destroy]
  end


  root :to => 'questions#today'

end
