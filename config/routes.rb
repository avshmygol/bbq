Rails.application.routes.draw do
  root "events#index"

  resources :events
  resources :users, only: %i[show edit update]
end
