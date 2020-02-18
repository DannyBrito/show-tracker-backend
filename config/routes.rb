Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :tvshows
      resources :users
      get '/watchlists/:id', to: 'tvshows#index'
      get '/tv_shows/search/:query', to: 'tvshows#search'
      get '/tv_shows_popular', to:"tvshows#popular"
      post '/login', to: 'auth#create'
      get '/auto_login', to: 'auth#auto_login'
      post 'tv_shows/save/:id', to: 'tvshows#add_tv_show'
    end
  end
end
