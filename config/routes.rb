Skyway::Application.routes.draw do
  resources :shows
  resources :songs
  root to: "home#index"
end
