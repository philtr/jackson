Jackson::Application.routes.draw do

  get '/sign-in',   to: 'sessions#new',      as: 'sign_in'
  get '/sign-out',  to: 'sessions#destroy',  as: 'sign_out'

  match '/auth/:provider/callback', to: 'sessions#create', via: [ :get, :post ]

  get "/profile", to: redirect("/profile/edit"), as: :profile
  get "/profile/edit", to: "profiles#edit", as: :edit_profile
  patch "/profile", to: "profiles#update", as: :update_profile

  resources :events do
    resources :responses, only: [:index, :create, :update, :destroy ]
  end

  get '/dashboard', to: 'dashboard#index', as: 'dashboard'

  get '/home', to: 'base#home', as: 'home'

  root to: 'base#home'
end
