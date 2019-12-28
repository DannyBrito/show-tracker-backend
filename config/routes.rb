Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  #need to revaluate to limit routes that are not being used
  namespace :api do
    namespace :v1 do
      resources :tv_shows
      resources :watchlists
      resources :users
      get '/tv_shows/search/:query', to: 'tv_shows#search_and_save'
      post '/login', to: 'auth#create'
    end
  end
  
end
