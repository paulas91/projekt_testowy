# frozen_string_literal: true

Rails.application.routes.draw do

  devise_for :users
  root 'items#index'
  resources :items do
    collection do
      get :active
      get :inactive
      get :borrowed
      get :on_place
    end
  end

  resources :users
  resources :friends, only: %i[index show]

end
