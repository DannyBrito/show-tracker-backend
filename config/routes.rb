Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :tv_shows
      resources :watchlists
      get '/tv_shows/search/:query', to: 'tv_shows#search_and_save'
    end
  end
  
end
