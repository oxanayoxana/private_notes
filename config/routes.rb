# frozen_string_literal: true

Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  devise_for :users
  get 'welcome/index'
  resources :notes

  authenticated :user do
    root 'notes#index'
  end

  root 'welcome#index'
end
