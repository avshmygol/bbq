Rails.application.routes.draw do
  resources :photos
  root "events#index"

  devise_for :users

  resources :events do
    post :show, on: :member

    resources :comments, only: %i[create destroy]
    resources :subscriptions, only: %i[create destroy]
    resources :photos, only: %i[create destroy]
  end

  resources :users, only: %i[show]
end
