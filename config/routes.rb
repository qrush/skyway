Rails.application.routes.draw do
  resource :tour

  resources :shows do
    resource :setlist

    collection do
      get :latest, format: :json
    end
  end

  resources :attendances
  resources :fans

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

  resources :imports do
    member do
      patch :confirm
    end
  end

  get '/news' => redirect('https://facebook.com/aqueousband')

  resources :lyrics
  resources :albums

  resources :searches, path: "search"
  resources :announcements
  resource :admin

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
    year = path_params[:year]
    slug = path_params[:slug]

    if slug =~ /_/
      "/shows/#{year}-#{slug.gsub("_", "-")}"
    else
      "/shows?year=#{year}"
    end
  }

  get "/:page.php", format: false, to: redirect('/%{page}')

  get "/auth/auth0/callback" => "auth0#callback"
  get "/auth/failure" => "auth0#failure"
  get "/auth/logout" => "auth0#logout"

  get "/sitemap.xml" => "sitemap#index", :format => "xml", :as => :sitemap

  ORIG_HOST = 'aqueousband.com'
  ORIG_URL = "https://#{ORIG_HOST}"
  root to: redirect(ORIG_URL)

  %W(
    /home
    /about
    /contact
    /music
  ).each do |page|
    get page => redirect(host: ORIG_HOST)
  end

  get "/*id" => 'pages#show', as: :page, format: false
end
