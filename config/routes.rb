Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  post '/logout' => 'sessions#destroy'

  post '/tasks/:id/toggle' => 'tasks#toggleCompleted'

  get '/auth/facebook/callback' => 'sessions#createfacebook'

  scope 'lists/:id' do
    get '/add_users' => 'user_lists#new'
    post '/add_users' => 'user_lists#create'
    resources :tasks
  end

  resources :users, only: [:new, :create]
  resources :lists
  

  root 'home#home'
end
