Rails.application.routes.draw do
  get "homepages/home", to: "homepages#home", as: 'home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "homepages/home"
end
