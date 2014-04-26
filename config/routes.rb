Skyway::Application.routes.draw do
  resources :shows

  resources :songs do
    member do
      patch :merge
    end
  end

  resources :venues do
    member do
      patch :merge
    end
  end

  resources :searches, path: "search"
  resource :admin

  root to: "home#index"
end
