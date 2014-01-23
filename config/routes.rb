Jackson::Application.routes.draw do

  get '/sign-in',   to: 'sessions#new',      as: 'sign_in'
  get '/sign-out',  to: 'sessions#destroy',  as: 'sign_out'

  scope :auth do
    get ':provider/callback', to: 'sessions#create'
  end

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
