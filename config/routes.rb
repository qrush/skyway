Skyway::Application.routes.draw do
  resources :shows
  root to: "shows#index"
end
