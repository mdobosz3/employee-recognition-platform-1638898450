# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, path: 'admin'
  devise_for :employees, path: 'employees'

  resources :employees, only: %i[show edit update]
  resources :kudos
  resources :rewards, only: %i[index show]
  resources :orders, only: %i[index create]

  root 'kudos#index'

  namespace :admin do
    root to: 'pages#dashboard'
    resources :kudos
    resources :company_values
    resources :rewards do
      collection { post :import }
    end
    resources :categories
    resources :category_rewards
    resources :orders, only: %i[index update]
    resources :employees, except: %i[new create] do
      collection do
        get 'edit_kudos_for_all'
        patch 'update_kudos_for_all'
      end
    end
  end
end
