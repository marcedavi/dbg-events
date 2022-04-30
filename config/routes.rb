Rails.application.routes.draw do
    devise_for :users
    
    root "events#index"
    
    # Errors
    match "/403", to: "errors#forbidden", via: :all
    match "/404", to: "errors#not_found", via: :all
    match "/500", to: "errors#internal_server_error", via: :all

    # Events / Participations
    resources :events, shallow: true do
      resources :participations, only: [:index, :create, :update, :destroy]
    end

    # Users
    get 'created-events', to: 'users#created_events', as: 'created_events'
    get 'joined-events', to: 'users#joined_events', as: 'joined_events'
end