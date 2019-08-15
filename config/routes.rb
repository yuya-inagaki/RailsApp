Rails.application.routes.draw do
  
  get '/login', to: 'users#login_form', as: 'login_form'
  post '/login', to: 'users#login', as: 'login'
  post '/logout', to: 'users#logout', as: 'logout'

  resources :users
end
