Rails.application.routes.draw do
    devise_for :users
    
    root "events#index"
    
    resources :events

    post 'events/:id/join', to: 'events#join', as: 'join_event'
    delete 'events/:id/leave', to: 'events#leave', as: 'leave_event'
end
