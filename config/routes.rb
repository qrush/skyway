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
  resources :announcements
  resource :admin

  get "/home" => "home#show"
  get "/setlists" => "home#index"

  get "/street.php", format: false, to: redirect('/mobilize')
  get "/setlists/setlists.php", format: false, to: redirect('/setlists')
  %w(mike dave evan nick).each do |player|
    get "/#{player}.php", format: false, to: redirect('/about')
  end

  get "/setlists/:slug.php", format: false, to: redirect { |path_params, req|
    date = Date.parse(path_params[:slug]) rescue nil
    if date
      "/shows/#{date}"
    else
      "/setlists"
    end
  }

  get "/setlists/:year/:slug.php", format: false, to: redirect { |path_params, req|
    "/shows/#{path_params[:year]}-#{path_params[:slug].gsub("_", "-")}"
  }

  get "/:page.php", format: false, to: redirect('/%{page}')

  root to: "home#show"
end
