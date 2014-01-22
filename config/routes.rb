Jackson::Application.routes.draw do

  get '/sign-in',   to: 'sessions#new',      as: 'sign_in'
  get '/sign-out',  to: 'sessions#destroy',  as: 'sign_out'

  scope :auth do
    get ':provider/callback', to: 'sessions#create'
  end

  resources :events
  resources :responses, except: [ :new, :edit ]

  get '/rsvp', to: 'responses#new', as: 'new_response'

  root to: 'dashboard#index'
end
