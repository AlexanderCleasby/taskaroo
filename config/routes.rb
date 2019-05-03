Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  post '/logout' => 'sessions#destroy'

  post '/tasks/:id/toggle' => 'tasks#toggleCompleted'

  resources :users, only: [:new, :create]
  resources :lists
  resources :tasks
  root 'home#home'
end
