Skyway::Application.routes.draw do
  resources :shows
  resources :songs do
    member do
      patch :merge
    end
  end
  resources :venues

  root to: "home#index"
end
