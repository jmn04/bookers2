Rails.application.routes.draw do
  get 'users/edit'
  get 'users/show'
  root to: 'homes#top'
  get 'home/about' => 'homes#about', as: 'about'
  devise_for :users
  resources :books
  # resources :books, only: [:new, :create, :index, :show, :destroy]
  resources :users, only: [:index, :show, :edit, :update]
end
