Tq::Application.routes.draw do
  # REV: don't leave whitespace at beginning end of blocks.

  devise_for :users, :controllers => {
    :omniauth_callbacks => "users/omniauth_callbacks"
  }
  resources :users, :only => [:index, :edit, :update, :destroy]
  resources :questions
  # REV: should be a member action on the questions resource
  post '/post_answers', to: 'questions#release'
  # REV: should be a silly_titles resource; maybe it just has an index
  # that gives you 10 or so.
  get '/silly_title', to: 'sillytitles#new'
  get '/scoreboard', to: 'users#scoreboard'

  resources :answers do
    post 'vote', to: 'answers#vote'
    resources :comments, :only => [:create, :destroy]
  end
  # REV: avoid two consecutive lines of whitespace.


  root :to => 'questions#today'

end
