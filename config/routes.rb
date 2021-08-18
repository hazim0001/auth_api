require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users
  resources :notes
  use_doorkeeper
  get '/privacy', to: 'home#privacy'
  get '/terms', to: 'home#terms'
  authenticate :user, ->(u) { u.admin? } do
    mount Sidekiq::Web => '/sidekiq'

    namespace :madmin do
    end
  end

  namespace :api do
    resources :notes
  end

  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
  end

  resources :notifications, only: [:index]
  resources :announcements, only: [:index]
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'notes#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
