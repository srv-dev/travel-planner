Rails.application.routes.draw do

  get 'pages/map' => 'pages#map'
  # root to: 'session#new'
  get '/login' => 'session#new' # Login form
  post '/login' => 'session#create' # Form submit, check credentials, create session
  delete '/login' => 'session#destroy' # logout(Delete session)

  resources :users
  resources :destinations

  resources :hotels
  resources :attractions
  resources :activities

end
