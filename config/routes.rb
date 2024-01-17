Rails.application.routes.draw do

  namespace :api do
    namespace :v0 do
      resources :users, only: :create

      get '/forecast', to: 'forecasts#show'
      post '/sessions', to: 'users#login'
      post '/road_trip', to: 'road_trips#create'
    end
  end

  
end
