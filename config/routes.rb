Jackson::Application.routes.draw do

  get '/sign-in',   to: 'sessions#new',      as: 'sign_in'
  get '/sign-out',  to: 'sessions#destroy',  as: 'sign_out'

  scope :auth do
    get ':provider/callback', to: 'sessions#create'
  end

  get "/profile", to: redirect("/profile/edit"), as: :profile
  get "/profile/edit", to: "profiles#edit", as: :edit_profile
  patch "/profile", to: "profiles#update", as: :update_profile

  resources :events do
    resources :responses, only: [ :create, :update, :destroy ]

    member do
      get :responses
    end
  end

  get '/dashboard', to: 'dashboard#index', as: 'dashboard'

  get '/home', to: 'base#home', as: 'home'

  root to: 'base#home'
end
