Skyway::Application.routes.draw do
  resource :tour

  resources :shows do
    resource :setlist
  end

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

  get "/home" => "home#show"
  get "/setlists" => "home#index"

  get "/:page.php", format: false, to: redirect('/%{page}')

  root to: "home#show"
end
