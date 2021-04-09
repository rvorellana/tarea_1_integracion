Rails.application.routes.draw do
  get "main_pages/home", to: "main_pages#home", as: 'home'
  get "main_pages/episodes/:serie/:season", to: "main_pages#episodes", as: 'episodes'
  get "main_pages/episode/:id/", to: "main_pages#episode", as: 'episode'
  get "main_pages/character/:name", to: "main_pages#character", as: 'character', :constraints => { :name => /[^\/]+/ }
  get "main_pages/search_character", to: "main_pages#search_character", as: 'search_character'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => "main_pages#home"

end
