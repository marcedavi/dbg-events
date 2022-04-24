Rails.application.routes.draw do
    devise_for :users
    
    root "events#index"
    
    resources :events do
        member do
            resources :participations, param: :participation_id, only: [:index, :create, :destroy, :update]
        end
    end

    # Users
    get 'created-events', to: 'users#created_events', as: 'created_events'
    get 'joined-events', to: 'users#joined_events', as: 'joined_events'
end