Rails.application.routes.draw do
  
  get '/login', to: 'users#login_form', as: 'login_form'
  post '/login', to: 'users#login', as: 'login'
  post '/logout', to: 'users#logout', as: 'logout'

  # SNSログイン
  get 'auth/:provider/callback', to: 'users#login'


  resources :users
end
