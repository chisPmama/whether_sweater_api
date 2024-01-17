Rails.application.routes.draw do

  namespace :api do
    namespace :v0 do
      get '/forecast', to: 'forecasts#show'
      resources :users, only: :create
      post '/sessions', to: 'users#login'
    end
  end

  
end
