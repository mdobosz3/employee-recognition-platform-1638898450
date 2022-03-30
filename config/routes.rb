# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, path: 'admin'
  devise_for :employees, path: 'employees'

  resources :kudos
  resources :rewards, only: %i[index show]
  resources :orders, only: %i[index create]

  root 'kudos#index'

  namespace :admin do
    root to: 'pages#dashboard'
    resources :kudos
    resources :company_values
    resources :rewards
    resources :orders, only: %i[index update]
    resources :employees, only: %i[index] do
      collection do
        get 'kudos_for_all'
        patch 'add_kudos_for_all'
      end
    end
  end
end
