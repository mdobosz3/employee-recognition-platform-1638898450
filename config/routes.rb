# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, path: 'admin'
  devise_for :employees, path: 'employees'

  resources :employees, only: %i[show edit update]
  resources :kudos
  resources :orders, only: %i[index new create]
  resources :rewards, only: %i[index show]

  root 'kudos#index'

  namespace :admin do
    root to: 'pages#dashboard'
    resources :categories
    resources :category_rewards
    resources :company_values
    resources :employees, except: %i[new create] do
      collection do
        get 'edit_kudos_for_all'
        patch 'update_kudos_for_all'
      end
    end
    resources :kudos
    resources :orders, only: %i[index update]
    resources :reward_codes, only: %i[create edit update destroy]
    resources :rewards do
      collection { post :import }
    end
  end
end
