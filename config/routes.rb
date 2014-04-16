Skyway::Application.routes.draw do
  resources :shows
  resources :songs
  resources :venues

  root to: "home#index"
end
