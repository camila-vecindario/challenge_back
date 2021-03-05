Rails.application.routes.draw do
  devise_for :users,
  controllers: {
    registrations: :registrations,
  }

  post '/auth/login', to: 'auth#login'
  get '/users', to: 'users#index'
  get '/*a', to: 'application#not_found'
end
