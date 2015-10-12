Skyway::Application.routes.draw do
  resource :tour

  resources :shows do
    resource :setlist

    collection do
      get :latest, format: :json
    end
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

  resources :articles, path: :news

  resources :searches, path: "search"
  resources :announcements
  resource :admin

  get "/home" => "home#show"
  get "/setlists" => "home#index"

  get "/sampler", to: redirect('http://sonicfarmstudio.com/aqueous')
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
    year = path_params[:year]
    slug = path_params[:slug]

    if slug =~ /_/
      "/shows/#{year}-#{slug.gsub("_", "-")}"
    else
      "/shows?year=#{year}"
    end
  }

  get "/:page.php", format: false, to: redirect('/%{page}')

  root to: "home#show"

  get "/*id" => 'pages#show', as: :page, format: false
end
