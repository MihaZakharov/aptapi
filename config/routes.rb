Rails.application.routes.draw do
 # resources :groups
devise_scope :user do
  get 'users/show', to: 'users/registrations#show'
end
  devise_for :users, controllers: { sessions: 'users/sessions', passwords: 'users/passwords', registrations: 'users/registrations' }
 # devise_for :users
#  resources :products
  
  get 'products/all(:id)', to: 'products#all'
  post 'products/searching', to: 'products#searching'
  get 'products/:id',      to: 'products#showproductsfromgroup'

  get 'groups/all',   to: 'groups#all'
  get 'groups/alln',   to: 'groups#alln'
  get 'groups/:id',        to: 'groups#showgrp'   

  get 'pharmacies/all(:id)',   to: 'pharmacies#all'

#  post 'makeinv/:invoice',   to: 'makeinv#all'
  post 'makeinv',   to: 'makeinv#all'
  post 'getinvoice',        to: 'getinvoice#showinv'   
  post 'getinvoice/detail',        to: 'getinvoice#showdetailinvoice'   
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
