Skyway::Application.routes.draw do
  resources :shows
  root to: "home#index"
end
