Rails.application.routes.draw do
    devise_for :users
    
    root "events#index"
    
    resources :events

    post 'participations/:event_id/create', to: 'participations#create', as: 'create_participation'
    delete 'participations/:event_id/destroy', to: 'participations#destroy', as: 'destroy_participation'
end
