Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      get 'login', to: 'users#login'
      get ':u/logout', to: 'users#logout'
      get 'current-user', to: 'users#create'
      get 'search-artists/:q/:u', to: 'recommendations#search'
      get 'get-more-artists/:q/:u', to: 'recommendations#search_on_click'
      get 'create-playlist/:u', to: 'playlists#create'
      get 'add-track-to-playlist/:u/:t/:p', to: 'playlists#add_track'
    end
  end
end
